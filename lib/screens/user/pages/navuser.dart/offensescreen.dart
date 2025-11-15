import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 🎨 Shared palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

/// ✅ Model
class Offense {
  final String title;
  final String section;
  final String fine;

  Offense({required this.title, required this.section, required this.fine});
}

/// ✅ Riverpod Provider
final offenseListProvider = Provider<List<Offense>>((ref) {
  return [
    Offense(
      title: "Riding without helmet by Driver (Owner)",
      section: "Sec 129/194(D) MVA",
      fine: "Rs 1000",
    ),
    Offense(
      title: "Riding without helmet by Pillion (Owner)",
      section: "Sec 129/194(D) MVA",
      fine: "Rs 1000",
    ),
    Offense(
      title:
          "Passenger Carrier MV without reflectors at front -white/both side -yellow & rear - red",
      section: "CMVR 104(1)(iv)/177 MVA",
      fine: "Rs 1000",
    ),
    Offense(
      title: "Driving without valid License",
      section: "Sec 3/181 MVA",
      fine: "Rs 1000",
    ),
    Offense(
      title: "Driving without valid License Below 16 years",
      section: "Sec 4/181 MVA",
      fine: "Rs 5000",
    ),
  ];
});

/// ✅ Offense Screen
class OffenseScreen extends ConsumerWidget {
  const OffenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offenses = ref.watch(offenseListProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        title: const Text(
          "🚦 Offenses & Fines",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/user/home'),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: offenses.length,
        itemBuilder: (context, index) {
          final offense = offenses[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: kCardBackground,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              leading: CircleAvatar(
                backgroundColor: kPrimary.withOpacity(0.1),
                radius: 24,
                child: const Icon(Icons.gavel, color: kPrimary, size: 26),
              ),
              title: Text(
                offense.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kTextPrimary,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  offense.section,
                  style: const TextStyle(fontSize: 14, color: kTextSecondary),
                ),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Text(
                  offense.fine,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
