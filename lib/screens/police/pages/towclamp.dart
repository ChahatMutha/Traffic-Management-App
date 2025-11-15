// Keep all existing imports
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Your custom palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

class TowClampPage extends StatefulWidget {
  const TowClampPage({super.key});

  @override
  State<TowClampPage> createState() => _TowClampPageState();
}

class _TowClampPageState extends State<TowClampPage> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleController = TextEditingController();
  final _destinationController = TextEditingController();
  final _penaltyController = TextEditingController();
  final _reasonController = TextEditingController();
  final _locationController = TextEditingController();

  final _statusOptions = ['Towed', 'Clamped', 'Released', 'Unpaid'];
  String _selectedStatus = 'Towed';
  String _entryStatusFilter = 'All';

  Uint8List? _imageBytes;
  String? _imageName;
  bool _showForm = true;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      final pos = await Geolocator.getCurrentPosition();
      final placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        _locationController.text =
            '${p.street}, ${p.locality}, ${p.administrativeArea}';
      }
    } catch (e) {
      _showSnackBar('❌ Location fetch failed: ${e.toString()}', false);
    }
  }

  String _generateMemoId() {
    final now = DateTime.now();
    final serial = now.microsecondsSinceEpoch
        .remainder(100000)
        .toString()
        .padLeft(5, '0');
    return 'TRFMUMCLMP$serial${now.year}';
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
    );
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _imageBytes = result.files.single.bytes;
        _imageName = result.files.single.name;
      });
    }
  }

  Future<void> _uploadData() async {
    if (!_formKey.currentState!.validate() || _imageBytes == null) {
      _showSnackBar('❌ Please complete all fields and pick an image.', false);
      return;
    }

    final supabase = Supabase.instance.client;
    final vehicleNumber = _vehicleController.text.trim();

    final vehicle = await supabase
        .from('vehicles')
        .select()
        .eq('vehicle_number', vehicleNumber)
        .eq('is_verified', true)
        .maybeSingle();

    if (vehicle == null) {
      _showSnackBar("❌ Vehicle not approved or doesn't exist.", false);
      return;
    }

    try {
      final imagePath =
          'tow_${DateTime.now().millisecondsSinceEpoch}_$_imageName';
      await supabase.storage
          .from('tow-photos')
          .uploadBinary(
            imagePath,
            _imageBytes!,
            fileOptions: const FileOptions(upsert: true),
          );

      final memoId = _generateMemoId();
      final userId = supabase.auth.currentUser?.id;

      await supabase.from('tow_clamp').insert({
        'memo_id': memoId,
        'vehicle_number': vehicleNumber,
        'location': _locationController.text.trim(),
        'destination': _destinationController.text.trim(),
        'penalty': int.tryParse(_penaltyController.text.trim()) ?? 0,
        'reason': _reasonController.text.trim(),
        'photo_path': imagePath,
        'status': _selectedStatus,
        'police_id': userId,
      });

      _showSnackBar('✅ Entry submitted successfully.', true);
      _clearForm();
    } catch (e) {
      _showSnackBar('❌ Upload failed: ${e.toString()}', false);
    }
  }

  void _clearForm() {
    setState(() {
      _vehicleController.clear();
      _destinationController.clear();
      _penaltyController.clear();
      _reasonController.clear();
      _selectedStatus = 'Towed';
      _imageBytes = null;
      _imageName = null;
      _fetchLocation();
    });
  }

  void _showSnackBar(String message, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchEntries() async {
    final supabase = Supabase.instance.client;
    final from = supabase.from('tow_clamp');
    final query = _entryStatusFilter == 'All'
        ? from.select()
        : from.select().eq('status', _entryStatusFilter);
    return await query.order('created_at', ascending: false);
  }

  Future<String?> _getSignedUrl(String path) async {
    return await Supabase.instance.client.storage
        .from('tow-photos')
        .createSignedUrl(path, 3600);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text('Tow & Clamp'),
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/police/home'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ToggleButtons(
                    isSelected: [_showForm, !_showForm],
                    onPressed: (index) =>
                        setState(() => _showForm = index == 0),
                    borderRadius: BorderRadius.circular(10),
                    fillColor: kPrimary,
                    selectedColor: Colors.white,
                    color: kPrimary,
                    constraints: const BoxConstraints(minHeight: 40),
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text('New Entry'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text('Past Entries'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: _showForm ? _buildFormView() : _buildPastEntriesView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _input(_vehicleController, 'Vehicle Number'),
          _input(_locationController, 'Location', readOnly: true),
          _input(_destinationController, 'Destination'),
          _input(_penaltyController, 'Penalty', isNumber: true),
          _input(_reasonController, 'Reason'),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedStatus,
            decoration: const InputDecoration(
              labelText: 'Status',
              border: OutlineInputBorder(),
            ),
            items: _statusOptions
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (val) => setState(() => _selectedStatus = val!),
          ),
          const SizedBox(height: 20),
          if (_imageBytes != null)
            Image.memory(_imageBytes!, height: 160)
          else
            const Text('No image selected'),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.photo),
            label: const Text('Pick Image'),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimary,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _uploadData,
            icon: const Icon(Icons.upload),
            label: const Text('Submit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastEntriesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Filter by Status",
          style: TextStyle(color: kTextPrimary, fontSize: 16),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _entryStatusFilter,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          items: [
            'All',
            ..._statusOptions,
          ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() => _entryStatusFilter = val);
            }
          },
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchEntries(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data!;
            if (data.isEmpty) return const Text('No entries found.');
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return FutureBuilder<String?>(
                  future: _getSignedUrl(item['photo_path']),
                  builder: (context, imgSnap) {
                    return Card(
                      color: kCardBackground,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading:
                            imgSnap.connectionState == ConnectionState.waiting
                            ? const SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(),
                              )
                            : (imgSnap.hasData
                                  ? Image.network(
                                      imgSnap.data!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.image_not_supported)),
                        title: Text(
                          item['vehicle_number'],
                          style: const TextStyle(color: kTextPrimary),
                        ),
                        subtitle: Text(
                          'Memo: ${item['memo_id']}\nStatus: ${item['status']}\nReason: ${item['reason']}',
                          style: const TextStyle(color: kTextSecondary),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _input(
    TextEditingController controller,
    String label, {
    bool readOnly = false,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'Required' : null,
      ),
    );
  }
}
