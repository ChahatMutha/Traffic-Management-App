import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart'; // Only if you're using GoRouter

final supabase = Supabase.instance.client;

const kBackground = Color(0xFFF5F6FA);
const kPrimary = Color(0xFF171476);
const kAccent = Color(0xFF0057FF);
const kTextPrimary = Color(0xFF1A1A1A);
const kTextSecondary = Color(0xFF6E6E6E);

// Fetch incident data from Supabase
final incidentReportsProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  try {
    final response = await supabase
        .from('incident_reports')
        .select()
        .order('created_at', ascending: false);

    if (response.isEmpty) {
      print('⚠️ No incidents found.');
    } else {
      print('📦 Fetched ${response.length} incidents.');
    }

    return List<Map<String, dynamic>>.from(response);
  } catch (e) {
    print('❌ Error fetching incidents: $e');
    throw Exception('Error loading incidents');
  }
});

class AdminIncidentScreen extends ConsumerWidget {
  const AdminIncidentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncIncidents = ref.watch(incidentReportsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: const Text(
          'Reported Incidents',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/admin/home'); // If using GoRouter
            // Navigator.pushNamed(context, '/admin/home'); // If using Navigator
          },
        ),
      ),
      backgroundColor: kBackground,
      body: asyncIncidents.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('❌ Error: $err')),
        data: (incidents) {
          if (incidents.isEmpty) {
            return const Center(child: Text('No incidents reported.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: incidents.length,
            itemBuilder: (context, index) {
              final incident = incidents[index];
              final type = incident['incident_type'] ?? 'Unknown';
              final description = incident['description'] ?? '';
              final location = incident['location'] ?? '';
              final createdAtStr = incident['created_at']?.toString() ?? '';
              final createdAt = DateTime.tryParse(createdAtStr);
              final image1 = incident['image_url_1'];
              final image2 = incident['image_url_2'];
              final image3 = incident['image_url_3'];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (createdAt != null)
                        Text(
                          'Date: ${_formatIST(createdAt)}',
                          style: const TextStyle(
                            color: kTextSecondary,
                            fontSize: 13,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        'Location: $location',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Description: $description',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [image1, image2, image3]
                            .whereType<String>()
                            .map(
                              (url) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    url,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatIST(DateTime date) {
    final ist = date.toUtc().add(const Duration(hours: 5, minutes: 30));
    return '${ist.day.toString().padLeft(2, '0')}/'
        '${ist.month.toString().padLeft(2, '0')}/'
        '${ist.year} ${ist.hour.toString().padLeft(2, '0')}:'
        '${ist.minute.toString().padLeft(2, '0')}';
  }
}
