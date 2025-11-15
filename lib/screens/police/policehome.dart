import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 🎨 Shared palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

class PoliceHomeDashboard extends ConsumerWidget {
  const PoliceHomeDashboard({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good morning!";
    } else if (hour >= 12 && hour < 17) {
      return "Good afternoon!";
    } else if (hour >= 17 && hour < 21) {
      return "Good evening!";
    } else {
      return "Good night!";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greeting = _getGreeting();

    final List<_DashboardCardData> cardData = [
      _DashboardCardData(
        "Create Challan",
        Icons.receipt_long,
        "/police/create-challan",
      ),
      _DashboardCardData(
        "All Challans",
        Icons.list_alt,
        "/police/all-challans",
      ),
      _DashboardCardData(
        "Tow & Clamp",
        Icons.car_crash_rounded,
        "/police/tow-clamp",
      ),
      _DashboardCardData("Settings", Icons.settings, "/police/settings"),
    ];

    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔝 Header Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🖼 Logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 48,
                      width: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),

                  /// 🧑 Officer greeting
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Hello, Officer ",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: kTextPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          greeting,
                          style: const TextStyle(
                            fontSize: 16,
                            color: kTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// ❓ Prompt
              const Text(
                "What would you like to do today?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kTextPrimary,
                ),
              ),

              const SizedBox(height: 24),

              /// 🧭 Dashboard Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: cardData
                      .map((card) => _DashboardCard(data: card))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardCardData {
  final String title;
  final IconData icon;
  final String route;
  _DashboardCardData(this.title, this.icon, this.route);
}

class _DashboardCard extends StatelessWidget {
  final _DashboardCardData data;
  const _DashboardCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(data.route),
      child: Container(
        decoration: BoxDecoration(
          color: kCardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: kPrimary.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: kPrimary.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(data.icon, size: 40, color: kPrimary),
            const SizedBox(height: 14),
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: kTextPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
