import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Custom Colors
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

class PoliceSignupScreen extends StatefulWidget {
  const PoliceSignupScreen({super.key});

  @override
  State<PoliceSignupScreen> createState() => _PoliceSignupScreenState();
}

class _PoliceSignupScreenState extends State<PoliceSignupScreen> {
  final supabase = Supabase.instance.client;

  final policeIdController = TextEditingController();
  final stationCodeController = TextEditingController();
  final regionController = TextEditingController();

  bool isLoading = false;

  Future<void> _submit() async {
    final policeId = policeIdController.text.trim();
    final stationCode = stationCodeController.text.trim();
    final region = regionController.text.trim();

    if (policeId.isEmpty || stationCode.isEmpty || region.isEmpty) {
      _showSnackBar('All fields are required.', isError: true);
      return;
    }

    final user = supabase.auth.currentUser;
    if (user == null) {
      _showSnackBar('Session expired. Please login again.', isError: true);
      context.go('/role');
      return;
    }

    setState(() => isLoading = true);

    try {
      await supabase.from('police').insert({
        'poid': user.id,
        'police_id': policeId,
        'station_code': stationCode,
        'region': region,
      });

      _showSnackBar('Signup successful! Awaiting approval.', isError: false);
      context.go('/police/waiting');
    } catch (e) {
      _showSnackBar('Signup failed: ${e.toString()}', isError: true);
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    policeIdController.dispose();
    stationCodeController.dispose();
    regionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text(
          'Police Signup',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: kPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            TextField(
              controller: policeIdController,
              decoration: const InputDecoration(
                labelText: 'Police ID',
                labelStyle: TextStyle(color: kTextSecondary),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: kTextPrimary),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: stationCodeController,
              decoration: const InputDecoration(
                labelText: 'Station Code',
                labelStyle: TextStyle(color: kTextSecondary),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: kTextPrimary),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: regionController,
              decoration: const InputDecoration(
                labelText: 'Region',
                labelStyle: TextStyle(color: kTextSecondary),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: kTextPrimary),
            ),
            const SizedBox(height: 30),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: kPrimary),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
                  ),
          ],
        ),
      ),
    );
  }
}
