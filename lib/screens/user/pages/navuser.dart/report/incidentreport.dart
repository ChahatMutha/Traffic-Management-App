import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

final supabase = Supabase.instance.client;

// Providers
final incidentTypeProvider = StateProvider<String?>((ref) => null);
final descriptionProvider = StateProvider<String>((ref) => '');
final locationProvider = StateProvider<String>((ref) => '');
final imagesProvider = StateProvider<List<File>>((ref) => []);
final isFetchingLocationProvider = StateProvider<bool>((ref) => false);

// Colors
const kBackground = Color(0xFFF5F6FA);
const kPrimary = Color(0xFF171476);
const kAccent = Color(0xFF0057FF);
const kTextPrimary = Color(0xFF1A1A1A);
const kTextSecondary = Color(0xFF6E6E6E);
const kCardBackground = Color(0xFFFFFFFF);
const kSnackSuccess = Color(0xFF4CAF50);
const kSnackError = Color(0xFFF44336);

class ReportIncidentScreen extends ConsumerStatefulWidget {
  const ReportIncidentScreen({super.key});

  @override
  ConsumerState<ReportIncidentScreen> createState() =>
      _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends ConsumerState<ReportIncidentScreen> {
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
    _fetchAndSetLocation();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _fetchAndSetLocation() async {
    ref.read(isFetchingLocationProvider.notifier).state = true;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw 'Location services are disabled.';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw 'Location permission denied.';
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String address = 'Unknown Location';
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        address = [
          place.name,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.postalCode,
        ].where((e) => e != null && e.isNotEmpty).join(', ');
      }

      ref.read(locationProvider.notifier).state = address;
      _locationController.text = address;
    } catch (e) {
      showErrorSnackBar(context, 'Failed to get location: $e');
    } finally {
      ref.read(isFetchingLocationProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedType = ref.watch(incidentTypeProvider);
    final imageFiles = ref.watch(imagesProvider);
    final isLoading = ref.watch(isFetchingLocationProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: const Text(
          'Report Incident',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 15,
                  color: kTextSecondary,
                  height: 1.4,
                ),
                children: [
                  const TextSpan(
                    text:
                        "Note - Please capture image and location details to help us take appropriate action. ",
                  ),
                  TextSpan(
                    text: "Learn more",
                    style: const TextStyle(
                      color: kAccent,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showSuccessSnackBar(
                          context,
                          "Incident guide coming soon.",
                        );
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Incident Type
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: _inputDecoration('Select Incident Type'),
              items: const [
                DropdownMenuItem(value: 'Accident', child: Text('Accident')),
                DropdownMenuItem(value: 'Fire', child: Text('Fire')),
                DropdownMenuItem(
                  value: 'Road Block',
                  child: Text('Road Block'),
                ),
                DropdownMenuItem(value: 'Others', child: Text('Others')),
              ],
              onChanged: (val) =>
                  ref.read(incidentTypeProvider.notifier).state = val,
            ),
            const SizedBox(height: 20),

            // Description
            TextFormField(
              maxLines: 3,
              style: const TextStyle(fontSize: 16),
              decoration: _inputDecoration('Description'),
              onChanged: (val) =>
                  ref.read(descriptionProvider.notifier).state = val,
            ),
            const SizedBox(height: 20),

            // Location
            TextFormField(
              controller: _locationController,
              readOnly: true,
              style: const TextStyle(fontSize: 16),
              decoration: _inputDecoration(
                isLoading ? 'Fetching location...' : 'Location',
              ),
            ),
            const SizedBox(height: 24),

            // Images Section
            const Text(
              'Upload up to 3 images',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: kTextPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(3, (index) {
                final file = index < imageFiles.length
                    ? imageFiles[index]
                    : null;
                return GestureDetector(
                  onTap: () => _pickImageAtIndex(ref, index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: file != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(file, fit: BoxFit.cover),
                          )
                        : const Icon(Icons.camera_alt, color: kTextSecondary),
                  ),
                );
              }),
            ),

            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _submitIncident(ref, context),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: kTextSecondary, fontSize: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kPrimary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Future<void> _pickImageAtIndex(WidgetRef ref, int index) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      final path = result.files.first.path;
      if (path != null) {
        final current = [...ref.read(imagesProvider)];
        if (index < current.length) {
          current[index] = File(path);
        } else {
          while (current.length < index) current.add(File(''));
          current.add(File(path));
        }
        ref.read(imagesProvider.notifier).state = current;
      }
    }
  }

  Future<void> _submitIncident(WidgetRef ref, BuildContext context) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      showErrorSnackBar(context, 'User not logged in');
      return;
    }

    final incidentType = ref.read(incidentTypeProvider);
    final description = ref.read(descriptionProvider);
    final location = _locationController.text;
    final images = ref.read(imagesProvider);

    if (incidentType == null || location.isEmpty) {
      showErrorSnackBar(context, 'Please fill all required fields');
      return;
    }

    try {
      final urls = await Future.wait(
        images.map((file) async {
          if (file.path.isEmpty) return null;
          final ext = file.path.split('.').last;
          final path = '${user.id}/incidents/${const Uuid().v4()}.$ext';
          await supabase.storage.from('incident-images').upload(path, file);
          return supabase.storage.from('incident-images').getPublicUrl(path);
        }),
      );

      final data = {
        'user_id': user.id,
        'incident_type': incidentType,
        'description': description,
        'location': location,
        'image_url_1': urls.isNotEmpty ? urls[0] : null,
        'image_url_2': urls.length > 1 ? urls[1] : null,
        'image_url_3': urls.length > 2 ? urls[2] : null,
      };

      await supabase.from('incident_reports').insert(data);
      showSuccessSnackBar(context, 'Incident submitted successfully!');
      Navigator.pop(context);
    } catch (e) {
      showErrorSnackBar(context, 'Error submitting incident: $e');
    }
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kSnackSuccess,
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kSnackError,
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
