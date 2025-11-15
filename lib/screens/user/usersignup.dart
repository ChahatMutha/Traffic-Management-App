import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

const kLabel = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: kTextPrimary,
);

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({super.key});

  @override
  State<UserSignupScreen> createState() => _UserSignupScreenState();
}

class _UserSignupScreenState extends State<UserSignupScreen> {
  final supabase = Supabase.instance.client;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _prefillPhone();
  }

  void _prefillPhone() {
    final phone = supabase.auth.currentUser?.phone;
    if (phone != null && phone.startsWith('+91')) {
      mobileController.text = phone.substring(3); // strip +91
    } else {
      mobileController.text = phone ?? '';
    }
  }

  Future<void> _submit() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final mobile = mobileController.text.trim();

    if (name.isEmpty || email.isEmpty || mobile.isEmpty) {
      _showSnackbar('All fields are required.', isError: true);
      return;
    }

    final user = supabase.auth.currentUser;
    if (user == null) {
      _showSnackbar('Session expired. Please login again.', isError: true);
      context.go('/user/auth');
      return;
    }

    setState(() => isLoading = true);

    try {
      final payload = {
        'pid': user.id,
        'full_name': name,
        'email': email,
        'mobile': mobile,
      };

      await supabase.from('people').insert(payload);

      _showSnackbar('Signup successful!', isError: false);
      await Future.delayed(const Duration(milliseconds: 800));
      context.go('/user/home');
    } catch (e) {
      _showSnackbar('Signup failed: ${e.toString()}', isError: true);
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showSnackbar(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red[600] : Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text('Complete Signup', style: kHeading),
        backgroundColor: kPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Let\'s get started', style: kHeading),
            const SizedBox(height: 6),
            Text(
              'Please fill in your details to complete registration.',
              style: kSubHeading,
            ),
            const SizedBox(height: 24),

            // Full Name
            Text('Full Name', style: kLabel),
            const SizedBox(height: 6),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your full name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: kCardBackground,
              ),
            ),
            const SizedBox(height: 16),

            // Email
            Text('Email Address', style: kLabel),
            const SizedBox(height: 6),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: kCardBackground,
              ),
            ),
            const SizedBox(height: 16),

            // Mobile
            Text('Mobile Number', style: kLabel),
            const SizedBox(height: 6),
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              readOnly: true,
              decoration: const InputDecoration(
                prefixText: '+91 ',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: kCardBackground,
              ),
            ),

            const SizedBox(height: 30),

            // Submit Button
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Submit & Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
