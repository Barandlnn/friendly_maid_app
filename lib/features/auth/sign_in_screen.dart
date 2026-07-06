import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth_service.dart';
import '../device/connect_device_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordHidden = true;

  bool get _emailLooksValid {
    final email = _emailController.text.trim();
    return email.contains('@') && email.contains('.');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Please fill in all fields.');
      return;
    }

    if (!_emailLooksValid) {
      _showMessage('Please enter a valid email address.');
      return;
    }

    if (password.length < 6) {
      _showMessage('Password must be at least 6 characters.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signIn(email: email, password: password);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ConnectDeviceScreen()),
      );
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

    // Figma frame genişliği 375px.
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
                width: x(298),
                height: y(68),
                child: Text(
                  'Welcome back\nYou’ve been missed',
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
                  enabled: !_isLoading,
                  showCheck: _emailLooksValid,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
              ),

              Positioned(
                top: y(334),
                left: x(30),
                width: x(318),
                height: y(46),
                child: _PasswordLine(
                  controller: _passwordController,
                  enabled: !_isLoading,
                  obscureText: _isPasswordHidden,
                  onSubmitted: (_) {
                    if (!_isLoading) {
                      _handleSignIn();
                    }
                  },
                  onToggleVisibility: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
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
                      color: _isLoading
                          ? const Color.fromRGBO(150, 150, 150, 1)
                          : const Color.fromRGBO(76, 175, 80, 1),
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
                        onTap: _isLoading ? null : _handleSignIn,
                        child: Center(
                          child: _isLoading
                              ? SizedBox(
                                  width: x(18),
                                  height: x(18),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Sign In',
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
                left: x(60),
                width: x(256),
                height: y(20),
                child: MouseRegion(
                  cursor: _isLoading
                      ? SystemMouseCursors.basic
                      : SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _isLoading
                        ? null
                        : () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignUpScreen(),
                              ),
                            );
                          },
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
                          TextSpan(text: 'Don’t have an account? '),
                          TextSpan(
                            text: 'Sign up',
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
    required this.enabled,
    required this.showCheck,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool enabled;
  final bool showCheck;
  final ValueChanged<String> onChanged;

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
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(170, 170, 170, 1),
            ),
          ),
        ),

        Positioned(
          top: 13,
          left: 0,
          right: showCheck ? 25 : 0,
          height: 32,
          child: TextField(
            controller: controller,
            enabled: enabled,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: onChanged,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(37, 65, 96, 1),
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: 'User@gmail.com',
              hintStyle: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(37, 65, 96, 0.65),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),

        if (showCheck)
          const Positioned(
            top: 17,
            right: 0,
            child: Icon(
              Icons.check,
              size: 18,
              color: Color.fromRGBO(76, 175, 80, 1),
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

class _PasswordLine extends StatelessWidget {
  const _PasswordLine({
    required this.controller,
    required this.enabled,
    required this.obscureText,
    required this.onSubmitted,
    required this.onToggleVisibility,
  });

  final TextEditingController controller;
  final bool enabled;
  final bool obscureText;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            'Password',
            style: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(170, 170, 170, 1),
            ),
          ),
        ),

        Positioned(
          top: 13,
          left: 0,
          right: 30,
          height: 32,
          child: TextField(
            controller: controller,
            enabled: enabled,
            obscureText: obscureText,
            textInputAction: TextInputAction.done,
            onSubmitted: onSubmitted,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(37, 65, 96, 1),
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: 'Password',
              hintStyle: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(37, 65, 96, 0.65),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),

        Positioned(
          top: 17,
          right: 0,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: enabled ? onToggleVisibility : null,
              child: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                size: 17,
                color: const Color.fromRGBO(139, 146, 154, 1),
              ),
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
