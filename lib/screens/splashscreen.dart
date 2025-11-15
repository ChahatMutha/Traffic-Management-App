import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final supabase = Supabase.instance.client;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    await Future.delayed(const Duration(seconds: 2)); // Optional splash delay

    try {
      if (supabase.auth.currentSession != null) {
        await supabase.auth.refreshSession();
      }
    } catch (_) {
      context.go('/role');
      return;
    }

    final user = supabase.auth.currentUser;
    if (user == null) {
      context.go('/role');
      return;
    }

    final uid = user.id;

    final person = await supabase
        .from('people')
        .select()
        .eq('pid', uid)
        .maybeSingle();

    if (person != null) {
      context.go('/user/home');
      return;
    }

    final police = await supabase
        .from('police')
        .select()
        .eq('poid', uid)
        .maybeSingle();

    if (police != null) {
      final isApproved = police['approved'] as bool? ?? false;
      if (isApproved) {
        context.go('/police/home');
      } else {
        context.go('/police/waiting');
      }
      return;
    }

    final admin = await supabase
        .from('admins')
        .select()
        .eq('aid', uid)
        .maybeSingle();

    if (admin != null) {
      context.go('/admin/home');
      return;
    }

    final role = await storage.read(key: 'selected_role');

    if (role == 'user') {
      context.go('/user/signup');
    } else if (role == 'police') {
      context.go('/police/signup');
    } else {
      context.go('/role'); // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Replace Icon with your logo from assets
            // Make sure you have added it in pubspec.yaml like:
            // assets:
            //   - assets/logo.png
            SizedBox(
              height: 200,
              width: 200,
              child: Image(
                image: AssetImage('assets/images/logo.png'), // your logo path
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Traffic360',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
