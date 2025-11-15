import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

// ---------------- Palette ----------------
const kBackground = Color(0xFFF5F6FA);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF1A1A1A);
const kTextSecondary = Color(0xFF6E6E6E);

// ---------------- Model ----------------
class ViolationReport {
  final String id;
  final String violationType;
  final String description;
  final String vehicleNumber;
  final DateTime createdAt;

  ViolationReport({
    required this.id,
    required this.violationType,
    required this.description,
    required this.vehicleNumber,
    required this.createdAt,
  });

  factory ViolationReport.fromMap(Map<String, dynamic> map) {
    final createdUtc = DateTime.parse(map['created_at']);
    return ViolationReport(
      id: map['id'],
      violationType: map['violation_type'],
      description: map['description'] ?? '',
      vehicleNumber: map['vehicle_number'],
      createdAt: createdUtc,
    );
  }
}

// ---------------- Providers ----------------
final violationHistoryProvider = FutureProvider<List<ViolationReport>>((
  ref,
) async {
  final user = supabase.auth.currentUser;
  if (user == null) return [];
  final res = await supabase
      .from('violation_reports')
      .select()
      .eq('user_id', user.id)
      .order('created_at', ascending: false);
  return (res as List).map((e) => ViolationReport.fromMap(e)).toList();
});

// ---------------- Screen ----------------
class ViolationHistoryScreen extends ConsumerWidget {
  const ViolationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final violationsAsync = ref.watch(violationHistoryProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Violation History',
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
                'No violations reported.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kTextSecondary,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: violations.length,
            itemBuilder: (context, index) {
              final v = violations[index];

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  child: Row(
                    children: [
                      // 🔵 Left blue strip
                      Container(
                        width: 6,
                        height: 140,
                        decoration: const BoxDecoration(
                          color: kPrimary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Violation Type
                              Text(
                                v.violationType,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kTextPrimary,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Vehicle Number
                              Text(
                                "Vehicle Number: ${v.vehicleNumber}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: kTextPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Description
                              if (v.description.isNotEmpty)
                                Text(
                                  "Description: ${v.description}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: kTextPrimary,
                                  ),
                                ),
                              if (v.description.isNotEmpty)
                                const SizedBox(height: 8),

                              // Date (non-italic)
                              Text(
                                "Date: ${_formatDateIST(v.createdAt)}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: kTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error: $err', style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  /// Format date to IST
  String _formatDateIST(DateTime date) {
    final istDate = date.toUtc().add(const Duration(hours: 5, minutes: 30));
    return '${istDate.day.toString().padLeft(2, '0')}/'
        '${istDate.month.toString().padLeft(2, '0')}/'
        '${istDate.year} '
        '${istDate.hour.toString().padLeft(2, '0')}:'
        '${istDate.minute.toString().padLeft(2, '0')}';
  }
}
