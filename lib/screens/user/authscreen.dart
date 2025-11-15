import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

/// 🎨 Shared palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

final storage = FlutterSecureStorage();

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  bool _otpSent = false;
  String? _phone;
  int _secondsRemaining = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() => _secondsRemaining = 60);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  /// ✅ Helper for snackbars
  void _showSnackBar(String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            Icon(
              success ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendOtp({bool isResend = false}) async {
    final input = _phoneController.text.trim();
    if (input.isEmpty) {
      _showSnackBar('📞 Please enter a phone number', success: false);
      return;
    }

    final phone = input.startsWith('+') ? input : '+91$input';
    _phone = phone;

    try {
      await Supabase.instance.client.auth.signInWithOtp(phone: phone);
      setState(() => _otpSent = true);
      _startTimer();

      _showSnackBar('✅ OTP sent successfully to $phone');
    } catch (e) {
      _showSnackBar('❌ Failed to send OTP: $e', success: false);
    }
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (_phone == null || otp.length != 6) {
      _showSnackBar('Enter a valid 6-digit OTP', success: false);
      return;
    }

    try {
      final res = await Supabase.instance.client.auth.verifyOTP(
        type: OtpType.sms,
        phone: _phone!,
        token: otp,
      );

      if (res.session != null) {
        final role = await storage.read(key: 'selected_role');
        final user = Supabase.instance.client.auth.currentUser;

        if (user == null) {
          context.go('/role');
          return;
        }

        final uid = user.id;
        if (role == 'user') {
          final person = await Supabase.instance.client
              .from('people')
              .select()
              .eq('pid', uid)
              .maybeSingle();
          if (person != null) {
            _showSnackBar('🎉 Welcome back!');
            context.go('/user/home');
          } else {
            _showSnackBar('ℹ️ New user – proceed to signup');
            context.go('/user/signup');
          }
        } else if (role == 'police') {
          final police = await Supabase.instance.client
              .from('police')
              .select()
              .eq('poid', uid)
              .maybeSingle();
          if (police != null) {
            final isApproved = police['approved'] as bool? ?? false;
            if (isApproved) {
              _showSnackBar('✅ Police login successful!');
              context.go('/police/home');
            } else {
              _showSnackBar('⏳ Waiting for approval.');
              context.go('/police/waiting');
            }
          } else {
            _showSnackBar('📝 Register as police.');
            context.go('/police/signup');
          }
        } else if (role == 'admin') {
          _showSnackBar('🔑 Redirecting to admin login');
          context.go('/admin/login');
        } else {
          _showSnackBar('❌ Role not found', success: false);
          context.go('/role');
        }
      } else {
        _showSnackBar('❌ Invalid OTP', success: false);
      }
    } catch (e) {
      _showSnackBar('OTP verification failed: $e', success: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isResendEnabled = _secondsRemaining == 0;

    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          children: [
            /// 🔙 Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: kPrimary, size: 28),
                  onPressed: () => context.go('/role'),
                ),
              ),
            ),

            /// 🌟 Main content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/logo.png', height: 120),
                        const SizedBox(height: 30),
                        const Text(
                          'Login with OTP',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: kTextPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),

                        if (!_otpSent) ...[
                          const Text(
                            'Enter your phone number',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kTextSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              prefixText: '+91 ',
                              labelStyle: const TextStyle(
                                color: kTextSecondary,
                              ),
                              filled: true,
                              fillColor: kCardBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kPrimary.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.send),
                              onPressed: _sendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              label: const Text(
                                'Send OTP',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ] else ...[
                          Text(
                            '✅ OTP sent to $_phone',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kTextPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            decoration: InputDecoration(
                              labelText: 'Enter OTP',
                              labelStyle: const TextStyle(
                                color: kTextSecondary,
                              ),
                              filled: true,
                              fillColor: kCardBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kPrimary.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.verified),
                              onPressed: _verifyOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              label: const Text(
                                'Verify & Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            isResendEnabled
                                ? 'Didn’t receive the code?'
                                : 'Resend in $_secondsRemaining seconds',
                            style: const TextStyle(
                              color: kTextSecondary,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (isResendEnabled)
                            TextButton(
                              onPressed: () => _sendOtp(isResend: true),
                              child: const Text(
                                'Resend OTP',
                                style: TextStyle(
                                  color: kPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ],
                    ),
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
