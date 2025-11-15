import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

// ---------------- Palette ----------------
const kBackground = Color(0xFFF5F6FA);
const kPrimary = Color(0xFF171476);
const kAccent = Color(0xFF0057FF);
const kTextPrimary = Color(0xFF1A1A1A);
const kTextSecondary = Color(0xFF4A4A4A);

final violationTypeProvider = StateProvider<String?>((ref) => null);
final descriptionProvider = StateProvider<String>((ref) => '');
final vehicleNumberProvider = StateProvider<String>((ref) => '');
final imageFile1Provider = StateProvider<File?>((ref) => null);
final imageFile2Provider = StateProvider<File?>((ref) => null);
final imageFile3Provider = StateProvider<File?>((ref) => null);

class ReportViolationDetailScreen extends ConsumerWidget {
  const ReportViolationDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supabase = Supabase.instance.client;
    final selectedViolationType = ref.watch(violationTypeProvider);
    final image1 = ref.watch(imageFile1Provider);
    final image2 = ref.watch(imageFile2Provider);
    final image3 = ref.watch(imageFile3Provider);

    final List<String> violationTypes = [
      'No Helmet',
      'Triple Seat',
      'No Seat Belt',
      'Mobile While Driving',
      'Wrong Parking',
      'Others',
    ];

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: const Text(
          "Report Violation",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
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
                        "Note - Please capture image and number of vehicle and evidence details to help us take appropriate action. ",
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
                        _showSnackBar(
                          context,
                          "This would open a guide or info page.",
                          isWarning: true,
                        );
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Dropdown
            DropdownButtonFormField<String>(
              value: selectedViolationType,
              hint: const Text(
                "Select Violation Type",
                style: TextStyle(color: kTextSecondary, fontSize: 15),
              ),
              items: violationTypes
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(
                        type,
                        style: const TextStyle(
                          fontSize: 16,
                          color: kTextPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                ref.read(violationTypeProvider.notifier).state = value;
              },
              decoration: _inputDecoration('Violation Type'),
            ),
            const SizedBox(height: 20),

            // Description
            TextFormField(
              style: const TextStyle(fontSize: 16, color: kTextPrimary),
              decoration: _inputDecoration("Description"),
              maxLines: 3,
              onChanged: (value) =>
                  ref.read(descriptionProvider.notifier).state = value,
            ),
            const SizedBox(height: 20),

            // Vehicle Number
            TextFormField(
              style: const TextStyle(fontSize: 16, color: kTextPrimary),
              decoration: _inputDecoration("Vehicle Number"),
              onChanged: (value) =>
                  ref.read(vehicleNumberProvider.notifier).state = value,
            ),
            const SizedBox(height: 24),

            const Text(
              "Upload up to 3 images:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: kTextPrimary,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSquareImagePicker(
                  context,
                  ref,
                  image1,
                  imageFile1Provider,
                ),
                _buildSquareImagePicker(
                  context,
                  ref,
                  image2,
                  imageFile2Provider,
                ),
                _buildSquareImagePicker(
                  context,
                  ref,
                  image3,
                  imageFile3Provider,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Submit Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                final type = ref.read(violationTypeProvider);
                final description = ref.read(descriptionProvider);
                final vehicleNumber = ref.read(vehicleNumberProvider);
                final img1 = ref.read(imageFile1Provider);
                final img2 = ref.read(imageFile2Provider);
                final img3 = ref.read(imageFile3Provider);
                final userId = supabase.auth.currentUser?.id;

                if (type == null ||
                    description.trim().isEmpty ||
                    vehicleNumber.trim().isEmpty ||
                    userId == null ||
                    (img1 == null && img2 == null && img3 == null)) {
                  _showSnackBar(
                    context,
                    "Fill all fields and upload at least 1 image.",
                    isError: true,
                  );
                  return;
                }

                try {
                  final imgUrl1 = await _uploadImage(img1, 'img1', userId);
                  final imgUrl2 = await _uploadImage(img2, 'img2', userId);
                  final imgUrl3 = await _uploadImage(img3, 'img3', userId);

                  await supabase.from('violation_reports').insert({
                    'user_id': userId,
                    'violation_type': type,
                    'description': description.trim(),
                    'vehicle_number': vehicleNumber.trim(),
                    'image1_url': imgUrl1,
                    'image2_url': imgUrl2,
                    'image3_url': imgUrl3,
                  });

                  _showSnackBar(context, "✅ Violation reported successfully.");
                  Navigator.pop(context);
                } catch (e) {
                  _showSnackBar(
                    context,
                    "❌ Submission failed. Please try again later.\nError: $e",
                    isError: true,
                  );
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Input decoration
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

  // 🔹 Upload image helper
  Future<String?> _uploadImage(File? file, String label, String userId) async {
    if (file == null) return null;
    final uuid = const Uuid().v4();
    final path = 'violations/$userId/$label-$uuid.jpg';
    final storage = Supabase.instance.client.storage.from('violation-images');
    await storage.upload(path, file);
    return storage.getPublicUrl(path);
  }

  // 🔹 Image picker widget
  Widget _buildSquareImagePicker(
    BuildContext context,
    WidgetRef ref,
    File? file,
    StateProvider<File?> provider,
  ) {
    return InkWell(
      onTap: () async {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.image,
        );
        if (result != null && result.files.single.path != null) {
          ref.read(provider.notifier).state = File(result.files.single.path!);
        }
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: file == null
            ? const Icon(Icons.camera_alt, color: kTextSecondary, size: 30)
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  file,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  // 🔹 Interactive SnackBar
  void _showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
    bool isWarning = false,
  }) {
    final backgroundColor = isError
        ? Colors.red.shade600
        : isWarning
        ? Colors.orange.shade700
        : Colors.green.shade600;
    final icon = isError
        ? Icons.error_outline
        : isWarning
        ? Icons.warning_amber
        : Icons.check_circle_outline;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: backgroundColor,
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
