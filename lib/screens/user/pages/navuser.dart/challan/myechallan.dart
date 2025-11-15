import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traffix/screens/user/models/challan_controller.dart';
import 'package:traffix/screens/user/pages/navuser.dart/challan/challandetailscreen.dart';
import 'package:go_router/go_router.dart';

/// 🎨 Color Palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);
const kAccentGreen = Color(0xFF4CAF50);

/// ✨ Consistent TextStyle for Type & Chassis info
const TextStyle kVehicleInfoTextStyle = TextStyle(
  fontSize: 16,
  color: kTextSecondary,
  fontWeight: FontWeight.w500,
);

class ChallanDashboardScreen extends ConsumerWidget {
  const ChallanDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challanData = ref.watch(challanProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          tooltip: 'Back',
          onPressed: () {
            context.go('/user/home');
          },
        ),
        title: const Text(
          'E-Challan Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: challanData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
        ),
        data: (vehicleMap) {
          if (vehicleMap.isEmpty) {
            return const Center(
              child: Text(
                'No challans found.',
                style: TextStyle(color: kTextPrimary, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vehicleMap.length,
            itemBuilder: (_, index) {
              final entry = vehicleMap.entries.elementAt(index);
              final vehicleId = entry.key;
              final info = entry.value as Map<String, dynamic>;

              final paid = info['paid'] ?? 0;
              final unpaid = info['unpaid'] ?? 0;

              return Card(
                color: kCardBackground,
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ChallanDetailScreen(vehicleId: vehicleId),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Row(
                    children: [
                      // Green accent line
                      Container(
                        width: 6,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: kAccentGreen,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Vehicle number
                              Text(
                                info['vehicle_number'] ?? 'Unknown Vehicle',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kTextPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              // Paid | Unpaid info with your desired style
                              Text(
                                'Paid: $paid | Unpaid: $unpaid',
                                style: kVehicleInfoTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.chevron_right, color: kPrimary),
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
