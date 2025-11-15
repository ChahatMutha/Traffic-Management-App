import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

/// 📦 Provider to fetch all grievance receipts
final adminReceiptProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final response = await supabase
      .from('grievance_receipt')
      .select()
      .order('created_at', ascending: false);
  return response;
});

class AdminGrievanceReceiptScreen extends ConsumerWidget {
  const AdminGrievanceReceiptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receipts = ref.watch(adminReceiptProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        title: const Text('Grievance Receipts'),
        backgroundColor: const Color(0xFF171476),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/admin/home'),
        ),
      ),
      body: receipts.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (data) {
          if (data.isEmpty) {
            return const Center(child: Text('No grievance receipts found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              final createdAt = DateTime.tryParse(item['created_at'] ?? '');
              final formattedDate = createdAt != null
                  ? DateFormat('dd MMM yyyy, hh:mm a').format(createdAt)
                  : 'Unknown';

              return Card(
                color: const Color(0xFFFFFFFF),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow('Receipt No:', item['receipt_no']),
                      _infoRow('Challan No:', item['challan_no']),
                      _infoRow('Vehicle No:', item['vehicle_no']),
                      _infoRow('Wrong Vehicle No:', item['wrong_vehicle_no']),
                      _infoRow(
                        'Correct Vehicle No:',
                        item['correct_vehicle_no'],
                      ),
                      _infoRow('Chassis Last 4:', item['chassis_last4']),
                      _infoRow('User ID:', item['uuid']),
                      _infoRow('Mobile No:', item['mobile_no']),
                      _infoRow('Email:', item['email']),
                      _infoRow('Amount:', '₹${item['amount']}'),
                      _infoRow('Reason:', item['reason']),
                      _infoRow('Remarks:', item['remarks'] ?? '—'),
                      _infoRow('Submitted:', formattedDate),
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

  /// 🔹 Reusable info row
  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          children: [
            TextSpan(
              text: '$label ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value ?? 'N/A'),
          ],
        ),
      ),
    );
  }
}
