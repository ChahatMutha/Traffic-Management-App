import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

final supabase = Supabase.instance.client;

// ---------------- Palette ----------------
const kBackground = Color(0xFFF5F6FA);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF1A1A1A);
const kTextSecondary = Color(0xFF6E6E6E);

// ---------------- Model ----------------
class ViolationReport {
  final String id;
  final String userId;
  final String violationType;
  final String description;
  final String vehicleNumber;
  final String? image1Url;
  final String? image2Url;
  final String? image3Url;
  final DateTime createdAt;

  ViolationReport({
    required this.id,
    required this.userId,
    required this.violationType,
    required this.description,
    required this.vehicleNumber,
    required this.image1Url,
    required this.image2Url,
    required this.image3Url,
    required this.createdAt,
  });

  factory ViolationReport.fromMap(Map<String, dynamic> map) {
    return ViolationReport(
      id: map['id'],
      userId: map['user_id'],
      violationType: map['violation_type'],
      description: map['description'] ?? '',
      vehicleNumber: map['vehicle_number'],
      image1Url: map['image1_url'],
      image2Url: map['image2_url'],
      image3Url: map['image3_url'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}

// ---------------- Provider ----------------
final allViolationsProvider = FutureProvider<List<ViolationReport>>((
  ref,
) async {
  final res = await supabase
      .from('violation_reports')
      .select()
      .order('created_at', ascending: false);
  return (res as List).map((e) => ViolationReport.fromMap(e)).toList();
});

// ---------------- Admin Screen ----------------
class AdminViolationScreen extends ConsumerWidget {
  const AdminViolationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final violationsAsync = ref.watch(allViolationsProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/admin/home'); // If using GoRouter
            // Navigator.pushNamed(context, '/admin/home'); // If using Navigator
          },
        ),
        title: const Text(
          'All Reported Violations',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: violationsAsync.when(
        data: (violations) {
          if (violations.isEmpty) {
            return const Center(
              child: Text(
                'No violations reported yet.',
                style: TextStyle(color: kTextSecondary),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: violations.length,
            itemBuilder: (context, index) {
              final v = violations[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        v.violationType,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Vehicle: ${v.vehicleNumber}",
                        style: const TextStyle(color: kTextPrimary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Description: ${v.description}",
                        style: const TextStyle(color: kTextSecondary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Date: ${_formatDateIST(v.createdAt)}",
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (v.image1Url != null)
                            _downloadButton("Image 1", v.image1Url!),
                          if (v.image2Url != null)
                            _downloadButton("Image 2", v.image2Url!),
                          if (v.image3Url != null)
                            _downloadButton("Image 3", v.image3Url!),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text("Error: $e", style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  Widget _downloadButton(String label, String url) {
    return ElevatedButton.icon(
      onPressed: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        }
      },
      icon: const Icon(Icons.download, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  String _formatDateIST(DateTime date) {
    final ist = date.toUtc().add(const Duration(hours: 5, minutes: 30));
    return '${ist.day.toString().padLeft(2, '0')}/'
        '${ist.month.toString().padLeft(2, '0')}/'
        '${ist.year} ${ist.hour.toString().padLeft(2, '0')}:'
        '${ist.minute.toString().padLeft(2, '0')}';
  }
}
