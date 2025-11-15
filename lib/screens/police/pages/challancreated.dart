import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 🎨 Palette (same as before)
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

/// ✅ Provider: fetch challans issued by current police
final policeChallansProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      final response = await supabase
          .from('challans')
          .select(
            'id, vehicle_id, amount, reason, status, issued_on, vehicles(vehicle_number)',
          )
          .eq('issued_by', user.id)
          .order('issued_on', ascending: false);

      return response;
    });

/// ✅ Screen
class PoliceChallansScreen extends ConsumerWidget {
  const PoliceChallansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challanAsync = ref.watch(policeChallansProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          tooltip: 'Back',
          onPressed: () => context.go('/police/home'),
        ),
        title: const Text(
          'My Issued Challans',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: challanAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: kPrimary)),
        error: (error, _) => Center(
          child: Text(
            '❌ Error: $error',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        data: (challans) {
          if (challans.isEmpty) {
            return const Center(
              child: Text(
                'No challans issued yet.',
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
            itemCount: challans.length,
            itemBuilder: (context, index) {
              final challan = challans[index];
              final vehicleNumber =
                  challan['vehicles']['vehicle_number'] ?? 'Unknown';
              final amount = challan['amount'];
              final reason = challan['reason'];
              final status = challan['status'];
              final issuedOn =
                  challan['issued_on']?.toString().split("T").first ?? 'N/A';

              // 🎯 Status color
              Color statusColor;
              switch (status) {
                case 'unpaid':
                  statusColor = Colors.orange.shade800;
                  break;
                case 'paid':
                  statusColor = Colors.green.shade700;
                  break;
                case 'cancelled':
                  statusColor = Colors.red.shade700;
                  break;
                default:
                  statusColor = kTextSecondary;
              }

              return Card(
                color: kCardBackground,
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Vehicle number (title)
                      Text(
                        vehicleNumber,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),

                      /// Reason
                      Text(
                        'Reason: $reason',
                        style: const TextStyle(
                          fontSize: 15,
                          color: kTextSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),

                      /// Amount
                      Text(
                        'Amount: ₹$amount',
                        style: const TextStyle(
                          fontSize: 15,
                          color: kTextSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),

                      /// Status
                      Text(
                        'Status: ${status[0].toUpperCase()}${status.substring(1)}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(height: 4),

                      /// Issued date
                      Text(
                        'Issued on: $issuedOn',
                        style: const TextStyle(
                          fontSize: 14,
                          color: kTextSecondary,
                          fontWeight: FontWeight.w400,
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
}
