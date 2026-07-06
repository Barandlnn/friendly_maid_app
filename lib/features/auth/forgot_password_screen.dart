import '../../services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(email);
  }

  Future<void> _sendResetEmail() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showMessage('Please enter your email address.');
      return;
    }

    if (!_isValidEmail(email)) {
      _showMessage('Please enter a valid email address.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.resetPassword(email: email);

      if (!mounted) return;

      _showMessage(
        'Password reset link sent. Please check your email inbox or spam folder.',
      );

      _emailController.clear();
    } catch (error) {
      if (!mounted) return;

      final message = error.toString().replaceFirst('Exception: ', '');
      _showMessage(message);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    final double frameWidth = screen.width > 420 ? 375 : screen.width;
    final double frameHeight = screen.height;

    final double sx = frameWidth / 375;
    final double sy = frameHeight / 812;

    double x(double value) => value * sx;
    double y(double value) => value * sy;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: frameWidth,
          height: double.infinity,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                top: y(120),
                left: x(30),
                width: x(164),
                height: y(68),
                child: Text(
                  'Forgot\nPassword?',
                  style: GoogleFonts.montserratAlternates(
                    fontSize: x(28),
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                    letterSpacing: 0.08,
                    color: const Color.fromRGBO(37, 65, 96, 1),
                  ),
                ),
              ),

              Positioned(
                top: y(266),
                left: x(30),
                width: x(318),
                height: y(46),
                child: _EmailLine(
                  controller: _emailController,
                  fontScale: x(1),
                  enabled: !_isLoading,
                ),
              ),

              Positioned(
                top: y(504),
                left: x(83),
                width: x(210),
                height: y(44),
                child: MouseRegion(
                  cursor: _isLoading
                      ? SystemMouseCursors.basic
                      : SystemMouseCursors.click,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(76, 175, 80, 1),
                      borderRadius: BorderRadius.circular(x(23)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(121, 121, 121, 0.5),
                          offset: Offset(0, 2),
                          blurRadius: 12,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(x(23)),
                        onTap: _isLoading ? null : _sendResetEmail,
                        child: Center(
                          child: _isLoading
                              ? SizedBox(
                                  width: x(20),
                                  height: x(20),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Send',
                                  style: GoogleFonts.montserrat(
                                    fontSize: x(16),
                                    fontWeight: FontWeight.w700,
                                    height: 1.0,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: y(574),
                left: x(61),
                width: x(253),
                height: y(20),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _isLoading ? null : _sendResetEmail,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: x(16),
                          fontWeight: FontWeight.w400,
                          height: 1.0,
                          letterSpacing: 0.04,
                          color: const Color.fromRGBO(37, 65, 96, 1),
                        ),
                        children: const [
                          TextSpan(text: 'Don’t receive an email? '),
                          TextSpan(
                            text: 'Resend',
                            style: TextStyle(
                              color: Color.fromRGBO(76, 175, 80, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: y(8),
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: x(134),
                    height: y(5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailLine extends StatelessWidget {
  const _EmailLine({
    required this.controller,
    required this.fontScale,
    required this.enabled,
  });

  final TextEditingController controller;
  final double fontScale;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            'Email',
            style: GoogleFonts.montserrat(
              fontSize: 11 * fontScale,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(170, 170, 170, 1),
            ),
          ),
        ),

        Positioned(
          top: 13,
          left: 0,
          right: 0,
         child: TextField(
            controller: controller,
            enabled: enabled,
            keyboardType: TextInputType.emailAddress,
            cursorColor: const Color.fromRGBO(76, 175, 80, 1),
            style: GoogleFonts.montserrat(
              fontSize: 14 * fontScale,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(37, 65, 96, 1),
            ),
            decoration: InputDecoration(
              hintText: 'User@gmail.com',
              hintStyle: GoogleFonts.montserrat(
                fontSize: 14 * fontScale,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(37, 65, 96, 0.55),
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 1,
            color: const Color.fromRGBO(220, 224, 228, 1),
          ),
        ),
      ],
    );
  }
}
