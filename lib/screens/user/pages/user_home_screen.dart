import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:traffix/screens/user/models/notification_controller.dart';

/// 🎨 Palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

class UserHomeScreen extends ConsumerStatefulWidget {
  const UserHomeScreen({super.key});

  @override
  ConsumerState<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends ConsumerState<UserHomeScreen> {
  final supabase = Supabase.instance.client;
  String greeting = '';
  String userName = '';
  int _currentIndex = 0;

  final List<_MenuItem> _menuItems = const [
    _MenuItem('My Vehicles', Icons.directions_car, '/user/vehicles'),
    _MenuItem('My Challans', Icons.receipt, '/user/challans'),
    _MenuItem('Pay E-Challan', Icons.payment, '/user/pay-challan'),
    _MenuItem('Tow Clamp', Icons.car_crash, '/user/tow'),
    _MenuItem('Grievance', Icons.feedback, '/user/grievance'),
    _MenuItem('Report Violation', Icons.camera_alt, '/civilian-report'),
    _MenuItem('Traffic Alerts', Icons.warning, '/alerts'),
    _MenuItem('Road Signs Quiz', Icons.quiz, '/user/quiz'),
    _MenuItem('Offenses & Fines', Icons.gavel, '/offenses'),
    _MenuItem('Road Signs', Icons.traffic, '/user/roadsigns'),
    _MenuItem('Public Notices', Icons.description, '/user/public-notices'),
  ];

  @override
  void initState() {
    super.initState();
    _loadGreeting();
  }

  Future<void> _loadGreeting() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final result = await supabase
        .from('people')
        .select('full_name')
        .eq('pid', user.id)
        .maybeSingle();

    final name = result?['full_name'] ?? 'User';

    final hour = DateTime.now().hour;
    String greet;
    if (hour < 12) {
      greet = 'Good morning';
    } else if (hour < 17) {
      greet = 'Good afternoon';
    } else if (hour < 21) {
      greet = 'Good evening';
    } else {
      greet = 'Good night';
    }

    setState(() {
      userName = name;
      greeting = greet;
    });
  }

  void _onNavTap(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        break;
      case 1:
        context.go('/user/contact');
        break;
      case 2:
        context.go('/user/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔝 Top bar with logo and greeting
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🏛️ Logo on left
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 👋 Greeting
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hey! $userName ',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
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
                  // 🔔 Notifications (Logout removed)
                  Consumer(
                    builder: (context, ref, _) {
                      final notifications = ref.watch(notificationProvider);
                      return notifications.when(
                        data: (list) {
                          final unreadCount = list
                              .where((n) => !n.isRead)
                              .length;
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.notifications,
                                  color: kTextPrimary,
                                ),
                                tooltip: 'Notifications',
                                onPressed: () {
                                  context.go('/notifications');
                                },
                              ),
                              if (unreadCount > 0)
                                Positioned(
                                  right: 6,
                                  top: 6,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 14,
                                      minHeight: 14,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$unreadCount',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                        loading: () => IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: kTextPrimary,
                          ),
                          onPressed: () {
                            context.go('/notifications');
                          },
                        ),
                        error: (e, st) => IconButton(
                          icon: const Icon(
                            Icons.notifications_off,
                            color: kTextPrimary,
                          ),
                          onPressed: () {},
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            /// 📌 Menu grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: _menuItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (_, index) {
                    final item = _menuItems[index];
                    return GestureDetector(
                      onTap: () => context.go(item.route),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: kCardBackground,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          border: Border.all(color: kPrimary.withOpacity(0.2)),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.icon, size: 40, color: kPrimary),
                            const SizedBox(height: 12),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: kTextPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      /// 🌊 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kCardBackground,
        currentIndex: _currentIndex,
        onTap: _onNavTap,
        selectedItemColor: kPrimary,
        unselectedItemColor: kTextSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Contact'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
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
