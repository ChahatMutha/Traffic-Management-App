import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// 🎨 Palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

/// ========== Providers ==========
final supabaseProvider = Provider((ref) => Supabase.instance.client);

final vehiclesProvider =
    StateNotifierProvider<
      VehicleController,
      AsyncValue<List<Map<String, dynamic>>>
    >((ref) => VehicleController(ref));

/// ========== Controller ==========
class VehicleController
    extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  final Ref ref;
  VehicleController(this.ref) : super(const AsyncLoading()) {
    loadVehicles();
  }

  Future<void> loadVehicles() async {
    final supabase = ref.read(supabaseProvider);
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;
    try {
      final response = await supabase
          .from('vehicles')
          .select()
          .eq('owner_id', userId)
          .order('created_at');
      state = AsyncData(List<Map<String, dynamic>>.from(response));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> addVehicle({
    required String vehicleNumber,
    required String selectedType,
    required PlatformFile rcPlatformFile,
    required String chassisNumber,
  }) async {
    final supabase = ref.read(supabaseProvider);
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) throw Exception("User not logged in");

    final ext = rcPlatformFile.extension ?? 'pdf';
    final fileName = 'rc_${DateTime.now().millisecondsSinceEpoch}.$ext';
    final storagePath = '$userId/$fileName';

    try {
      await supabase.storage
          .from('rc-docs')
          .uploadBinary(
            storagePath,
            rcPlatformFile.bytes!,
            fileOptions: const FileOptions(upsert: false),
          );

      await supabase.from('vehicles').insert({
        'owner_id': userId,
        'vehicle_number': vehicleNumber,
        'vehicle_type': selectedType,
        'rc_doc_url': storagePath,
        'chassis_number': chassisNumber,
      });

      await loadVehicles();
    } catch (e) {
      throw Exception("Failed to add vehicle: $e");
    }
  }

  Future<void> deleteVehicle(String id) async {
    final supabase = ref.read(supabaseProvider);
    try {
      final result = await supabase
          .from('vehicles')
          .select('rc_doc_url')
          .eq('id', id)
          .maybeSingle();
      final rcPath = result?['rc_doc_url'];
      if (rcPath != null) {
        await supabase.storage.from('rc-docs').remove([rcPath]);
      }
      await supabase.from('vehicles').delete().eq('id', id);
      await loadVehicles();
    } catch (e) {
      throw Exception("Failed to delete vehicle: $e");
    }
  }

  Future<void> viewRC(BuildContext context, String storagePath) async {
    try {
      final supabase = ref.read(supabaseProvider);
      final signedUrl = await supabase.storage
          .from('rc-docs')
          .createSignedUrl(storagePath, 3600);
      final uri = Uri.parse(signedUrl);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception("Could not open RC document.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade700,
          content: Text(
            'Failed to open RC: $e',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}

/// ========== Main Screen ==========
class MyVehiclesScreen extends ConsumerWidget {
  const MyVehiclesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesAsync = ref.watch(vehiclesProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          tooltip: 'Back',
          onPressed: () => {context.go('/user/home')},
        ),
        title: const Text(
          'My Vehicles',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            tooltip: 'Add Vehicle',
            onPressed: () => _showAddVehicleDialog(context, ref),
          ),
        ],
      ),
      body: vehiclesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            'Error: $e',
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
        data: (vehicles) => vehicles.isEmpty
            ? const Center(
                child: Text(
                  'No vehicles found.',
                  style: TextStyle(fontSize: 16, color: kTextPrimary),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: vehicles.length,
                itemBuilder: (_, index) {
                  final vehicle = vehicles[index];
                  final isVerified = vehicle['is_verified'];
                  String statusText;
                  Color statusColor = kTextSecondary;
                  if (isVerified == true) {
                    statusText = 'Approved';
                    statusColor = Colors.green.shade700;
                  } else if (isVerified == false) {
                    statusText = 'Rejected';
                    statusColor = Colors.red.shade700;
                  } else {
                    statusText = 'Pending';
                    statusColor = Colors.orange.shade800;
                  }

                  return Card(
                    color: kCardBackground,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  vehicle['vehicle_number'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: kTextPrimary,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    tooltip: 'View RC',
                                    icon: const Icon(
                                      Icons.visibility,
                                      color: kPrimary,
                                    ),
                                    onPressed: () => ref
                                        .read(vehiclesProvider.notifier)
                                        .viewRC(context, vehicle['rc_doc_url']),
                                  ),
                                  IconButton(
                                    tooltip: 'Delete Vehicle',
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      try {
                                        await ref
                                            .read(vehiclesProvider.notifier)
                                            .deleteVehicle(vehicle['id']);
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              backgroundColor:
                                                  Colors.green.shade700,
                                              content: const Text(
                                                'Vehicle deleted successfully',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              backgroundColor:
                                                  Colors.red.shade700,
                                              content: Text(
                                                'Delete failed: $e',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Type: ${vehicle['vehicle_type']}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: kTextSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Chassis No: ${vehicle['chassis_number'] ?? "N/A"}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: kTextSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Status: $statusText',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  /// ✨ Dialog with blue background and uppercase conversion
  Future<void> _showAddVehicleDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final vehicleNumberController = TextEditingController();
    final chassisNumberController = TextEditingController();
    String? selectedType;
    PlatformFile? rcPlatformFile;

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: kPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Add Vehicle',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: vehicleNumberController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Vehicle Number'),
                  onChanged: (val) {
                    vehicleNumberController.value = vehicleNumberController
                        .value
                        .copyWith(
                          text: val.toUpperCase(),
                          selection: TextSelection.collapsed(
                            offset: val.length,
                          ),
                        );
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: chassisNumberController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Chassis Number'),
                  onChanged: (val) {
                    chassisNumberController.value = chassisNumberController
                        .value
                        .copyWith(
                          text: val.toUpperCase(),
                          selection: TextSelection.collapsed(
                            offset: val.length,
                          ),
                        );
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  dropdownColor: kPrimary,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Vehicle Type'),
                  items: ['car', 'bike', 'truck', 'bus', 'other']
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(
                            type.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => selectedType = value),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.upload_file, color: Colors.white),
                  label: Text(
                    rcPlatformFile != null
                        ? 'RC Selected'
                        : 'Upload RC Document',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'pdf'],
                      withData: true,
                    );
                    if (result != null && result.files.single.bytes != null) {
                      setState(() => rcPlatformFile = result.files.single);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Add Vehicle',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () async {
              final vehicleNumber = vehicleNumberController.text
                  .trim()
                  .toUpperCase();
              final chassisNumber = chassisNumberController.text
                  .trim()
                  .toUpperCase();
              if (vehicleNumber.isEmpty ||
                  chassisNumber.isEmpty ||
                  selectedType == null ||
                  rcPlatformFile == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red.shade700,
                    content: const Text(
                      'All fields are required',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
                return;
              }
              try {
                await ref
                    .read(vehiclesProvider.notifier)
                    .addVehicle(
                      vehicleNumber: vehicleNumber,
                      selectedType: selectedType!,
                      rcPlatformFile: rcPlatformFile!,
                      chassisNumber: chassisNumber,
                    );
                if (context.mounted) Navigator.pop(context);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green.shade700,
                      content: const Text(
                        'Vehicle added successfully',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red.shade700,
                    content: Text(
                      'Upload failed: $e',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
