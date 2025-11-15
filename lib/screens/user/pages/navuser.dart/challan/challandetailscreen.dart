import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:geocoding/geocoding.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:traffix/screens/user/models/challandetail.dart';

// 🎨 Color Palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

// 📝 Text Style
const TextStyle kInfoStyle = TextStyle(
  fontSize: 15,
  color: kTextSecondary,
  fontWeight: FontWeight.w500,
);

// 🌍 Get Address from LatLng
Future<String?> getAddressFromLatLng(String location) async {
  try {
    final parts = location.split(',');
    if (parts.length != 2) return null;

    final lat = double.tryParse(parts[0]);
    final lng = double.tryParse(parts[1]);
    if (lat == null || lng == null) return null;

    final placemarks = await placemarkFromCoordinates(lat, lng);
    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      return "${place.locality ?? ''}, ${place.administrativeArea ?? ''}"
          .trim();
    }
  } catch (_) {
    return null;
  }
  return null;
}

class ChallanDetailScreen extends ConsumerWidget {
  final String vehicleId;

  const ChallanDetailScreen({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challans = ref.watch(challanDetailProvider(vehicleId));
    final notifier = ref.read(challanDetailProvider(vehicleId).notifier);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Challan Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                FilterChip(
                  showCheckmark: false,
                  label: Text(
                    "Unpaid",
                    style: TextStyle(
                      color: notifier.filter == ChallanFilter.unpaid
                          ? Colors.white
                          : kTextSecondary,
                    ),
                  ),
                  selected: notifier.filter == ChallanFilter.unpaid,
                  selectedColor: kPrimary,
                  backgroundColor: Colors.white,
                  onSelected: (_) => notifier.setFilter(ChallanFilter.unpaid),
                ),
                const SizedBox(width: 10),
                FilterChip(
                  showCheckmark: false,
                  label: Text(
                    "Paid",
                    style: TextStyle(
                      color: notifier.filter == ChallanFilter.paid
                          ? Colors.white
                          : kTextSecondary,
                    ),
                  ),
                  selected: notifier.filter == ChallanFilter.paid,
                  selectedColor: kPrimary,
                  backgroundColor: Colors.white,
                  onSelected: (_) => notifier.setFilter(ChallanFilter.paid),
                ),
              ],
            ),
          ),
          Expanded(
            child: challans.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Text("Error: $e", style: TextStyle(color: Colors.red)),
              ),
              data: (list) {
                if (list.isEmpty) {
                  return const Center(
                    child: Text(
                      'No challans found.',
                      style: TextStyle(fontSize: 16, color: kTextSecondary),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final challan = list[index];
                    final isPaid = challan['status'] == 'paid';
                    final issuedDate = DateTime.tryParse(
                      challan['issued_on'] ?? '',
                    );
                    final formattedDate = issuedDate != null
                        ? "${issuedDate.year}-${issuedDate.month.toString().padLeft(2, '0')}-${issuedDate.day.toString().padLeft(2, '0')}"
                        : 'N/A';

                    final rawPhotoPath = challan['photo_url'] ?? '';
                    final location = challan['location'] ?? '';
                    final challanNumber = challan['challan_number'] ?? 'N/A';
                    final vehicleType = challan['vehicle_type'] ?? 'N/A';
                    final chassisNumber = challan['chassis_number'] ?? 'N/A';
                    final reason = challan['reason'] ?? 'N/A';
                    final amount = challan['amount'] ?? 0;

                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kCardBackground,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        border: Border(
                          left: BorderSide(
                            color: isPaid ? Colors.green : Colors.red,
                            width: 4,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ₹amount and eye icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹$amount',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isPaid ? Colors.green : Colors.red,
                                ),
                              ),
                              if (rawPhotoPath.isNotEmpty)
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_red_eye,
                                    color: kPrimary,
                                  ),
                                  onPressed: () async {
                                    try {
                                      final supabase = Supabase.instance.client;
                                      final signed = await supabase.storage
                                          .from('challan-proofs')
                                          .createSignedUrl(rawPhotoPath, 60);

                                      final signedUrl = signed;
                                      if (await canLaunchUrl(
                                        Uri.parse(signedUrl),
                                      )) {
                                        await launchUrl(
                                          Uri.parse(signedUrl),
                                          mode: LaunchMode.externalApplication,
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              '❌ Could not open image',
                                            ),
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '❌ Error: ${e.toString()}',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            reason,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Challan Number: $challanNumber',
                            style: kInfoStyle,
                          ),
                          Text('Issued On: $formattedDate', style: kInfoStyle),
                          Text('Type: $vehicleType', style: kInfoStyle),
                          Text('Chassis No: $chassisNumber', style: kInfoStyle),
                          const SizedBox(height: 8),

                          // 📍 Location Section
                          FutureBuilder<String?>(
                            future: getAddressFromLatLng(location),
                            builder: (context, snapshot) {
                              if (location.isEmpty || location == 'Location') {
                                return Text(
                                  'Location: Unknown',
                                  style: kInfoStyle,
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text(
                                  'Location: Resolving...',
                                  style: kInfoStyle,
                                );
                              } else {
                                final resolved = snapshot.data ?? location;
                                return Text(
                                  'Location: $resolved',
                                  style: kInfoStyle,
                                );
                              }
                            },
                          ),

                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              isPaid
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.receipt_long,
                                        color: kPrimary,
                                      ),
                                      onPressed: () async {
                                        final url = challan['receipt_url'];
                                        if (url != null &&
                                            await canLaunchUrl(
                                              Uri.parse(url),
                                            )) {
                                          await launchUrl(
                                            Uri.parse(url),
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        }
                                      },
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        final challanId = challan['id'];
                                        context.go(
                                          '/user/pay-challan?challanId=$challanId',
                                        );
                                      },
                                      child: const Text(
                                        'Pay',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
