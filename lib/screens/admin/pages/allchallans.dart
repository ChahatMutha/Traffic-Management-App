import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

/// 🎨 Color Palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

/// ✅ Challan Model
class Challan {
  final String id;
  final String vehicleId;
  final double amount;
  final String reason;
  final String location;
  final String photoUrl;

  Challan({
    required this.id,
    required this.vehicleId,
    required this.amount,
    required this.reason,
    required this.location,
    required this.photoUrl,
  });

  factory Challan.fromMap(Map<String, dynamic> map) {
    return Challan(
      id: map['id'],
      vehicleId: map['vehicle_id'],
      amount: (map['amount'] as num).toDouble(),
      reason: map['reason'] ?? '',
      location: map['location'] ?? '',
      photoUrl: map['photo_url'] ?? '',
    );
  }
}

/// 🧠 Riverpod Provider
final allChallansProvider = FutureProvider<List<Challan>>((ref) async {
  final supabase = Supabase.instance.client;
  final response = await supabase
      .from('challans')
      .select('id, vehicle_id, amount, reason, location, photo_url')
      .order('issued_on', ascending: false);

  return (response as List)
      .map((e) => Challan.fromMap(e as Map<String, dynamic>))
      .toList();
});

/// 📄 Admin All Challans Screen
class AdminAllChallansScreen extends ConsumerWidget {
  const AdminAllChallansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challansAsync = ref.watch(allChallansProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text('All Challans'),
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/admin/home'),
        ),
      ),
      body: challansAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (challans) {
          if (challans.isEmpty) {
            return const Center(child: Text('No challans found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: challans.length,
            itemBuilder: (context, index) {
              final challan = challans[index];
              return Card(
                color: kCardBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),

                            /// 💰 Amount
                            Text(
                              "₹${challan.amount.toStringAsFixed(0)}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),

                            /// ⚠️ Reason
                            Text(
                              challan.reason,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 10),

                            /// 🚗 Vehicle Number
                            _buildRow("Vehicle No", challan.vehicleId),

                            /// 📍 Location
                            _buildRow("Location", challan.location),
                          ],
                        ),
                      ),

                      /// 👁️ Eye icon for viewing image
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.visibility_outlined,
                            color: kPrimary,
                          ),
                          onPressed: () =>
                              _showFullImage(context, challan.photoUrl),
                        ),
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

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: kTextPrimary,
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: kTextSecondary)),
          ),
        ],
      ),
    );
  }

  void _showFullImage(BuildContext context, String photoUrl) {
    if (photoUrl.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No photo available")));
      return;
    }

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black87,
        insetPadding: const EdgeInsets.all(10),
        child: InteractiveViewer(
          child: Stack(
            children: [
              Center(
                child: Image.network(
                  photoUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Failed to load image",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
