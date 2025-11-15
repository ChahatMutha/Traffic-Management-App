import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

// 1️⃣ Get current user's vehicle number
final userVehicleProvider = FutureProvider<String>((ref) async {
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception('User not logged in');

  final userId = user.id;

  // Fetch from 'people'
  final peopleList = await supabase
      .from('people')
      .select('pid')
      .eq('pid', userId)
      .limit(1);

  if (peopleList.isEmpty) throw Exception('User not found in people table');
  final pid = peopleList.first['pid'];

  // Fetch from 'vehicles'
  final vehicleList = await supabase
      .from('vehicles')
      .select('vehicle_number')
      .eq('owner_id', pid)
      .limit(1);

  if (vehicleList.isEmpty || vehicleList.first['vehicle_number'] == null) {
    throw Exception('No vehicle found for this user');
  }

  return (vehicleList.first['vehicle_number'] as String)
      .toUpperCase()
      .replaceAll(' ', '');
});

// 2️⃣ Fetch tow/clamp entries for user's vehicle
final towClampEntriesProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((
      ref,
      vehicleNumber,
    ) async {
      final response = await supabase
          .from('tow_clamp')
          .select('*')
          .eq('vehicle_number', vehicleNumber)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    });

// 3️⃣ Get signed image URL
final signedUrlProvider = FutureProvider.family<String?, String>((
  ref,
  path,
) async {
  if (path.isEmpty) return null;

  final result = await supabase.storage
      .from('tow-photos') // your bucket
      .createSignedUrl(path, 60 * 60); // 1 hour valid

  return result;
});

// 4️⃣ UI Screen
class TowClampUserScreen extends ConsumerWidget {
  const TowClampUserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleAsync = ref.watch(userVehicleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tow & Clamp Records'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/user/home'),
        ),
      ),
      body: vehicleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (vehicleNumber) {
          final entriesAsync = ref.watch(
            towClampEntriesProvider(vehicleNumber),
          );

          return entriesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error loading records: $e')),
            data: (entries) {
              if (entries.isEmpty) {
                return const Center(child: Text('No Tow/Clamp records found.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final item = entries[index];
                  final photoPath = item['photo_path'] as String? ?? '';
                  final imageAsync = ref.watch(signedUrlProvider(photoPath));

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    child: ListTile(
                      leading: imageAsync.when(
                        loading: () => const SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        error: (_, __) => const Icon(Icons.broken_image),
                        data: (url) => url != null
                            ? Image.network(
                                url,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.image_not_supported),
                      ),
                      title: Text(item['memo_id'] ?? 'Memo ID'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status: ${item['status'] ?? ''}'),
                          Text('Location: ${item['location'] ?? ''}'),
                          Text('Destination: ${item['destination'] ?? ''}'),
                          Text('Reason: ${item['reason'] ?? ''}'),
                          Text('Penalty: ₹${item['penalty'] ?? 0}'),
                          Text(
                            'Date: ${item['created_at'] != null ? DateTime.parse(item['created_at']).toLocal().toString().substring(0, 16) : 'Unknown'}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
