import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 🎨 Color Palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

/// ✨ Typography
const kHeading = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: kTextPrimary,
);

const kSubHeading = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: kTextSecondary,
);

const kMenuTitle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: kTextPrimary,
);

class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  ConsumerState<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen> {
  final supabase = Supabase.instance.client;
  String greeting = '';
  String adminName = '';

  final List<_MenuItem> _menuItems = const [
    _MenuItem('Approve Vehicle', Icons.verified_user, '/admin/vehicles'),
    _MenuItem('All Challans', Icons.receipt_long, '/admin/challans'),
    _MenuItem('Public Notices', Icons.warning_amber, '/admin/notices'),
    _MenuItem('Add Quiz', Icons.quiz, '/admin/quiz-upload'),
    _MenuItem('Manage Police', Icons.shield, '/admin/managepolice'),
    _MenuItem('Settings', Icons.settings, '/admin/settings'),
    _MenuItem('Alert Traffic', Icons.notification_important, '/admin/alert'),
    _MenuItem('Incident', Icons.report_problem, '/admin/incidents'),
    _MenuItem('Report', Icons.insert_chart, '/admin/report'),
    _MenuItem(
      'Grievance Challan',
      Icons.description,
      '/admin/greivance-challan',
    ),
    _MenuItem('Grievance Receipt', Icons.receipt, '/admin/greivance-receipt'),
  ];

  @override
  void initState() {
    super.initState();
    _loadGreeting();
  }

  Future<void> _loadGreeting() async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        setState(() {
          adminName = 'Admin';
          greeting = _getTimeBasedGreeting('Admin');
        });
        return;
      }

      final result = await supabase
          .from('admins')
          .select('full_name')
          .eq('aid', user.id)
          .maybeSingle();

      final name = result?['full_name'] ?? 'Admin';
      final greet = _getTimeBasedGreeting(name);

      setState(() {
        adminName = name;
        greeting = greet;
      });
    } catch (e) {
      setState(() {
        adminName = 'Admin';
        greeting = _getTimeBasedGreeting('Admin');
      });
    }
  }

  String _getTimeBasedGreeting(String name) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              /// 🔝 Top Row: Logo + Greeting + Logout
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Logo
                  Image.asset('assets/images/logo.png', height: 56),

                  const SizedBox(width: 12),

                  /// Admin name + greeting
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hey! $adminName', style: kHeading),
                        const SizedBox(height: 4),
                        Text(
                          greeting.isNotEmpty
                              ? greeting
                              : 'Loading your greeting…',
                          style: kSubHeading,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  /// Logout button
                ],
              ),

              const SizedBox(height: 24),

              /// 🟦 Grid Menu
              Expanded(
                child: GridView.builder(
                  itemCount: _menuItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (_, index) {
                    final item = _menuItems[index];
                    return GestureDetector(
                      onTap: () => context.go(item.route),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kCardBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: kPrimary.withOpacity(0.15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.icon, size: 36, color: kPrimary),
                            const SizedBox(height: 12),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: kMenuTitle,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final String route;
  const _MenuItem(this.title, this.icon, this.route);
}
