import 'dart:async';
import 'package:flutter/material.dart';
import 'main_dashboard_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Empty phone controller so no static mobile number is hardcoded
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpDigitControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  bool _isOtpSent = false;
  bool _isLoading = false;
  String? _errorMessage;
  int _resendCountdown = 30;
  Timer? _resendTimer;
  bool _isPhoneValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    final text = _phoneController.text.trim();
    final isValid = text.length >= 10;
    if (isValid != _isPhoneValid) {
      setState(() => _isPhoneValid = isValid);
    }
  }

  void _startResendTimer() {
    _resendCountdown = 30;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        if (_resendCountdown > 0) {
          setState(() => _resendCountdown--);
        } else {
          _resendTimer?.cancel();
        }
      }
    });
  }

  void _sendOtp() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      // If empty, auto-fill default demo number for convenience
      _phoneController.text = '9876543210';
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isOtpSent = true;
          // Auto-fill mock OTP digits "123456" so user doesn't have to manually type
          const mockOtp = '123456';
          for (int i = 0; i < 6; i++) {
            _otpDigitControllers[i].text = mockOtp[i];
          }
        });
        _startResendTimer();
      }
    });
  }

  void _verifyOtp() {
    final enteredOtp = _otpDigitControllers.map((c) => c.text.trim()).join();
    if (enteredOtp.length < 6) {
      // Auto fill demo OTP if incomplete
      _fillDemoOtp();
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, a1, a2) => const MainDashboardScreen(),
            transitionsBuilder: (context, a1, a2, child) {
              return FadeTransition(opacity: a1, child: child);
            },
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      }
    });
  }

  void _fillDemoOtp() {
    const demoCode = '123456';
    for (int i = 0; i < 6; i++) {
      _otpDigitControllers[i].text = demoCode[i];
    }
    setState(() => _errorMessage = null);
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _phoneController.dispose();
    for (final c in _otpDigitControllers) {
      c.dispose();
    }
    for (final fn in _otpFocusNodes) {
      fn.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Brand Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6B21A8), Color(0xFF9333EA)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Color(0x666B21A8), blurRadius: 8),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            '1Fi',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '1Fi FinTech',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF059669).withAlpha(30),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF10B981).withAlpha(80)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.verified_user_rounded, color: Color(0xFF10B981), size: 11),
                        SizedBox(width: 3),
                        Text('RBI Regulated', style: TextStyle(color: Color(0xFF10B981), fontSize: 9, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Hero Credit Card Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E1B4B), Color(0xFF311042), Color(0xFF0F172A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF6B21A8).withAlpha(80), width: 1.2),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x306B21A8),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF059669),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'PRE-APPROVED CREDIT',
                            style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(Icons.bolt_rounded, color: Colors.amber, size: 13),
                            SizedBox(width: 2),
                            Text(
                              '0% Interest',
                              style: TextStyle(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Up to ₹2,50,000 Limit',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Instant digital approval • Zero paperwork required',
                      style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 11),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Auth Glass Box
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF334155)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x30000000),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isOtpSent ? 'Verify OTP Code' : 'Login / Signup',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _isOtpSent
                          ? 'Enter 6-digit OTP code sent to +91 ${_phoneController.text}'
                          : 'Enter mobile number to check instant credit eligibility.',
                      style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11, height: 1.3),
                    ),

                    const SizedBox(height: 14),

                    if (_errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7F1D1D).withAlpha(80),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFDC2626)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: Color(0xFFFCA5A5), size: 14),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(_errorMessage!, style: const TextStyle(color: Color(0xFFFCA5A5), fontSize: 11)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    if (!_isOtpSent) ...[
                      // Phone Number Entry
                      const Text(
                        'Mobile Number',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFFCBD5E1)),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isPhoneValid ? const Color(0xFF10B981) : const Color(0xFF475569),
                            width: _isPhoneValid ? 1.5 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide(color: Color(0xFF334155))),
                              ),
                              child: const Row(
                                children: [
                                  Text('🇮🇳', style: TextStyle(fontSize: 14)),
                                  SizedBox(width: 4),
                                  Text('+91', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1),
                                decoration: const InputDecoration(
                                  hintText: 'Enter 10-digit mobile number',
                                  hintStyle: TextStyle(color: Color(0xFF64748B), letterSpacing: 0, fontSize: 12),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            if (_isPhoneValid)
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 18),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _sendOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6B21A8),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Get OTP Verification Code', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                    SizedBox(width: 6),
                                    Icon(Icons.arrow_forward_rounded, size: 16),
                                  ],
                                ),
                        ),
                      ),
                    ] else ...[
                      // 6 Individual OTP Digit Boxes (Pre-filled 123456!)
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('6-Digit Verification Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFFCBD5E1))),
                          Text('✓ Pre-filled (123456)', style: TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 38,
                            height: 44,
                            child: TextField(
                              controller: _otpDigitControllers[index],
                              focusNode: _otpFocusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                counterText: '',
                                fillColor: const Color(0xFF0F172A),
                                filled: true,
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xFF475569)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xFFA855F7), width: 2),
                                ),
                              ),
                              onChanged: (val) {
                                if (val.isNotEmpty && index < 5) {
                                  _otpFocusNodes[index + 1].requestFocus();
                                } else if (val.isEmpty && index > 0) {
                                  _otpFocusNodes[index - 1].requestFocus();
                                }
                              },
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _fillDemoOtp,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFF059669).withAlpha(30),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFF10B981).withAlpha(60)),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.touch_app_rounded, color: Color(0xFF10B981), size: 11),
                                  SizedBox(width: 3),
                                  Text('Auto-fill 123456', style: TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => setState(() => _isOtpSent = false),
                            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 0)),
                            child: const Text('Edit Phone', style: TextStyle(color: Color(0xFFA855F7), fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _verifyOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF059669),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : const Text('Verify & Unlock Credit Dashboard', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Bottom Security Line
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline_rounded, color: Color(0xFF64748B), size: 12),
                    SizedBox(width: 4),
                    Text('256-Bit SSL Encrypted • 1Fi Security Guaranteed', style: TextStyle(color: Color(0xFF64748B), fontSize: 10)),
                  ],
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
