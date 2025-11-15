import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const kBackground = Color(0xFFF5F6FA);
const kPrimary = Color(0xFF171476);
const kCardBackground = Colors.white;
const kTextPrimary = Color(0xFF1A1A1A);
const kTextSecondary = Color(0xFF6E6E6E);

class CivilianReportMenu extends ConsumerWidget {
  const CivilianReportMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuItems = [
      {
        'title': 'Report Violation',
        'icon': Icons.report_gmailerrorred_outlined,
        'route': '/report-violation',
      },
      {
        'title': 'Violation History',
        'icon': Icons.history_edu_outlined,
        'route': '/violation-history',
      },
      {
        'title': 'Report Incident',
        'icon': Icons.report_problem_outlined,
        'route': '/report-incident',
      },
      {
        'title': 'Incident History',
        'icon': Icons.history_outlined,
        'route': '/incident-history',
      },
    ];

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/user/home');
          },
        ),
        title: const Text(
          'Civilian Report',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: menuItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return InkWell(
            onTap: () {
              context.push(item['route'] as String);
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: kCardBackground,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'] as IconData, size: 48, color: kPrimary),
                  const SizedBox(height: 14),
                  Text(
                    item['title'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kTextPrimary,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
