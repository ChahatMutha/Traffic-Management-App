import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

/// 🎨 ---- Color Palette ----
const kBackground = Color(0xFFF5F6FA);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF1A1A1A);
const kTextSecondary = Color(0xFF6E6E6E);

/// 🔄 Provider to fetch incidents
final incidentsProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final user = supabase.auth.currentUser;
  if (user == null) return [];
  final response = await supabase
      .from('incident_reports')
      .select()
      .eq('user_id', user.id)
      .order('created_at', ascending: false);
  return List<Map<String, dynamic>>.from(response);
});

class IncidentHistoryScreen extends ConsumerWidget {
  const IncidentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incidentsAsync = ref.watch(incidentsProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Incident History',
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
      ),
      body: incidentsAsync.when(
        data: (incidents) {
          if (incidents.isEmpty) {
            return const Center(
              child: Text(
                'No incidents found.',
                style: TextStyle(
                  fontSize: 16,
                  color: kTextSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: incidents.length,
            itemBuilder: (context, index) {
              final incident = incidents[index];
              final type = incident['incident_type'] ?? 'N/A';
              final desc = incident['description'] ?? '';
              final location = incident['location'] ?? '';

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Blue strip
                    Container(
                      width: 6,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                    ),
                    // Card content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Incident type with icon
                            Row(
                              children: [
                                const Icon(Icons.report, color: kPrimary),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    type,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: kTextPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Description
                            if (desc.isNotEmpty)
                              Text(
                                desc,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: kTextPrimary,
                                ),
                              ),
                            const SizedBox(height: 8),

                            // Location with icon
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: kTextSecondary,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    location,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: kTextSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),

                            // Date (bottom right)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                _formatDateIST(incident['created_at']),
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: kTextSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  /// Format UTC timestamp to IST string
  String _formatDateIST(dynamic createdAt) {
    try {
      final utcDate = DateTime.tryParse(createdAt.toString());
      if (utcDate != null) {
        final istDate = utcDate.toUtc().add(
          const Duration(hours: 5, minutes: 30),
        );
        return '${istDate.day.toString().padLeft(2, '0')}/'
            '${istDate.month.toString().padLeft(2, '0')}/'
            '${istDate.year} '
            '${istDate.hour.toString().padLeft(2, '0')}:'
            '${istDate.minute.toString().padLeft(2, '0')}';
      }
    } catch (_) {}
    return '';
  }
}
