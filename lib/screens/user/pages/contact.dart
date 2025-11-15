import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 🎨 Neutral Color Palette
const kBackground = Color(0xFFF9FAFB);
const kPrimary = Color(0xFF171476);
const kPrimaryLight = Color(0xFF1976D2);
const kCardBackground = Color(0xFFFFFFFF);
const kTextPrimary = Color(0xFF212121);
const kTextSecondary = Color(0xFF616161);

/// ✨ Typography
const kHeading = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
  color: kTextPrimary,
);

const kSubHeading = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: kTextSecondary,
);

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  int _currentIndex = 1; // Contact is selected

  void _onNavTap(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        context.go('/user/home');
        break;
      case 1:
        break; // Already here
      case 2:
        context.go('/user/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: kPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          color: kCardBackground,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Need Help or Support?', style: kHeading),
                const SizedBox(height: 24),

                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.phone, color: kPrimary),
                  title: Text(
                    'Traffic Helpline',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kTextPrimary,
                    ),
                  ),
                  subtitle: Text('1800-123-456', style: kSubHeading),
                ),
                const Divider(),

                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.email, color: kPrimary),
                  title: Text(
                    'Email Us',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kTextPrimary,
                    ),
                  ),
                  subtitle: Text('support@traffic360.in', style: kSubHeading),
                ),
                const Divider(),

                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.location_on, color: kPrimary),
                  title: Text(
                    'Office Address',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kTextPrimary,
                    ),
                  ),
                  subtitle: Text(
                    'Traffic Control HQ, Mumbai\nMaharashtra, India',
                    style: kSubHeading,
                  ),
                ),
                const Divider(),

                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.access_time, color: kPrimary),
                  title: Text(
                    'Working Hours',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kTextPrimary,
                    ),
                  ),
                  subtitle: Text('Mon–Sat: 9 AM to 6 PM', style: kSubHeading),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
        selectedItemColor: kPrimary,
        unselectedItemColor: kTextSecondary,
        backgroundColor: Colors.white,
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
