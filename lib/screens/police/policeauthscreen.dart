import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

/// 🎨 Police palette
const kPolicePrimary = Color(0xFF171476);
const kPoliceBackground = Color(0xFFEEEEEE);
const kPoliceTextPrimary = Color(0xFF060606);
const kPoliceTextSecondary = Color(0xFF555555);
const kPoliceCard = Colors.white;

class PoliceAuthScreen extends StatefulWidget {
  const PoliceAuthScreen({super.key});

  @override
  State<PoliceAuthScreen> createState() => _PoliceAuthScreenState();
}

class _PoliceAuthScreenState extends State<PoliceAuthScreen> {
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

  /// ✅ Helper to show beautiful snackbars
  void _showSnackBar(String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: success ? Colors.green : Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              success ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
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

  Future<void> _sendOtp({bool isResend = false}) async {
    final input = _phoneController.text.trim();
    if (input.isEmpty) {
      _showSnackBar('📞 Please enter your phone number', success: false);
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
      debugPrint('❌ OTP send failed: $e');
      _showSnackBar('❌ Failed to send OTP: $e', success: false);
    }
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (_phone == null || otp.length != 6) {
      _showSnackBar('⚠️ Enter a valid 6-digit OTP', success: false);
      return;
    }

    try {
      final res = await Supabase.instance.client.auth.verifyOTP(
        type: OtpType.sms,
        phone: _phone!,
        token: otp,
      );

      if (res.session != null) {
        final user = Supabase.instance.client.auth.currentUser;
        if (user == null) {
          context.go('/role');
          return;
        }

        final uid = user.id;
        final police = await Supabase.instance.client
            .from('police')
            .select()
            .eq('poid', uid)
            .maybeSingle();

        if (police != null) {
          final isApproved = police['approved'] as bool? ?? false;
          if (isApproved) {
            _showSnackBar('✅ Welcome back, Officer!');
            context.go('/police/home');
          } else {
            _showSnackBar('⏳ Your account is pending approval.');
            context.go('/police/waiting');
          }
        } else {
          _showSnackBar('📝 Please complete police registration.');
          context.go('/police/signup');
        }
      } else {
        _showSnackBar('❌ Invalid OTP, try again.', success: false);
      }
    } catch (e) {
      debugPrint('❌ OTP verification failed: $e');
      _showSnackBar('❌ OTP verification failed: $e', success: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isResendEnabled = _secondsRemaining == 0;

    return Scaffold(
      backgroundColor: kPoliceBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 🔙 Back button with padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: kPolicePrimary,
                    size: 28,
                  ),
                  onPressed: () => context.go('/role'),
                ),
              ),
            ),

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
                          'Police Login with OTP',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: kPoliceTextPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),

                        if (!_otpSent) ...[
                          const Text(
                            'Enter your police phone number',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kPoliceTextSecondary,
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
                                color: kPoliceTextSecondary,
                              ),
                              filled: true,
                              fillColor: kPoliceCard,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kPolicePrimary.withOpacity(0.3),
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
                              label: const Text('Send OTP'),
                              onPressed: _sendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPolicePrimary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
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
                              color: kPoliceTextPrimary,
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
                                color: kPoliceTextSecondary,
                              ),
                              filled: true,
                              fillColor: kPoliceCard,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kPolicePrimary.withOpacity(0.3),
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
                              label: const Text('Verify & Continue'),
                              onPressed: _verifyOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPolicePrimary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
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
                              color: kPoliceTextSecondary,
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
                                  color: kPolicePrimary,
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
