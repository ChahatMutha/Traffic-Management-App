import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

final supabase = Supabase.instance.client;

class CreateChallanScreen extends ConsumerStatefulWidget {
  const CreateChallanScreen({super.key});

  @override
  ConsumerState<CreateChallanScreen> createState() =>
      _CreateChallanScreenState();
}

class _CreateChallanScreenState extends ConsumerState<CreateChallanScreen> {
  final _vehicleNumberController = TextEditingController();
  final _reasonController = TextEditingController();
  final _amountController = TextEditingController();
  final _locationController = TextEditingController();

  PlatformFile? _pickedFile;
  Uint8List? _webImageBytes;
  File? _mobileFile;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchLocation(); // Auto-fetch on screen load
  }

  void _showSnackBar({required String message, required bool success}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              success ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: success ? Colors.green.shade700 : Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _fetchLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showSnackBar(
          message: 'Location services are disabled.',
          success: false,
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnackBar(message: 'Location permission denied.', success: false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showSnackBar(
          message: 'Location permission permanently denied.',
          success: false,
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address =
            '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}';
        setState(() => _locationController.text = address);
      }
    } catch (e) {
      _showSnackBar(message: 'Failed to fetch location: $e', success: false);
    }
  }

  Future<void> _pickProof() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      setState(() {
        _pickedFile = file;
        if (kIsWeb) {
          _webImageBytes = file.bytes;
        } else {
          _mobileFile = File(file.path!);
        }
      });
    }
  }

  Future<void> _createChallan() async {
    final vehicleNumber = _vehicleNumberController.text.trim().toUpperCase();
    final reason = _reasonController.text.trim();
    final amount = num.tryParse(_amountController.text.trim());
    final location = _locationController.text.trim();
    final userId = supabase.auth.currentUser?.id;

    if (vehicleNumber.isEmpty ||
        reason.isEmpty ||
        amount == null ||
        location.isEmpty) {
      _showSnackBar(
        message: '⚠️ Please fill all fields before submitting.',
        success: false,
      );
      return;
    }

    if (userId == null) {
      _showSnackBar(message: '⚠️ You are not logged in.', success: false);
      return;
    }

    setState(() => _loading = true);

    try {
      final vehicleRes = await supabase
          .from('vehicles')
          .select('id')
          .eq('is_verified', true)
          .ilike('vehicle_number', vehicleNumber)
          .maybeSingle();

      if (vehicleRes == null) {
        throw Exception(
          'No verified vehicle found with number "$vehicleNumber".',
        );
      }

      final vehicleId = vehicleRes['id'] as String;

      String? photoUrl;
      if (_pickedFile != null) {
        final fileName = 'proof_${const Uuid().v4()}.jpg';
        final path = '$vehicleId/$fileName';

        if (kIsWeb) {
          await supabase.storage
              .from('challan-proofs')
              .uploadBinary(path, _webImageBytes!);
        } else {
          await supabase.storage
              .from('challan-proofs')
              .upload(path, _mobileFile!);
        }

        photoUrl = await supabase.storage
            .from('challan-proofs')
            .createSignedUrl(path, 3600);
      }

      await supabase.from('challans').insert({
        'vehicle_id': vehicleId,
        'reason': reason,
        'amount': amount,
        'photo_url': photoUrl,
        'issued_by': userId,
        'location': location,
        'status': 'unpaid',
      });

      if (mounted) {
        _showSnackBar(
          message: '✅ Challan created successfully!',
          success: true,
        );
        context.go('/police/all-challans');
      }
    } catch (e) {
      _showSnackBar(message: '❌ Error: $e', success: false);
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePreview = kIsWeb
        ? _webImageBytes != null
              ? Image.memory(_webImageBytes!, height: 150)
              : null
        : _mobileFile != null
        ? Image.file(_mobileFile!, height: 150)
        : null;

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/police/home'),
        ),
        title: const Text(
          'Create Challan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ListView(
            children: [
              const Text(
                "Fill in the details below",
                style: TextStyle(fontSize: 16, color: kTextSecondary),
              ),
              const SizedBox(height: 24),

              _buildTextField(_vehicleNumberController, 'Vehicle Number'),
              const SizedBox(height: 16),

              _buildTextField(_reasonController, 'Reason / Offense'),
              const SizedBox(height: 16),

              _buildTextField(_amountController, 'Amount', isNumber: true),
              const SizedBox(height: 16),

              _buildTextField(
                _locationController,
                'Location (auto-filled)',
                readOnly: true,
              ),
              const SizedBox(height: 20),

              if (imagePreview != null) ...[
                const Text(
                  "Selected Proof Image:",
                  style: TextStyle(fontSize: 14, color: kTextSecondary),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imagePreview,
                ),
                const SizedBox(height: 16),
              ],

              OutlinedButton.icon(
                onPressed: _pickProof,
                icon: const Icon(Icons.image, color: kPrimary),
                label: const Text(
                  'Upload Photo Proof',
                  style: TextStyle(color: kPrimary),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: kPrimary.withOpacity(0.5)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _createChallan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Submit Challan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: kTextPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: kTextSecondary),
        filled: true,
        fillColor: kCardBackground,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
