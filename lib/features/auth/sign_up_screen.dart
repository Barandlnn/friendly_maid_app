import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign_in_screen.dart';
import 'forgot_password_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                width: x(192),
                height: y(78),
                child: Text(
                  'Create\nan account',
                  style: GoogleFonts.montserratAlternates(
                    fontSize: x(32),
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
                child: const _AuthInputLine(label: 'Name', value: 'John'),
              ),

              Positioned(
                top: y(334),
                left: x(30),
                width: x(318),
                height: y(46),
                child: const _AuthInputLine(
                  label: 'Email',
                  value: 'User@gmail.com',
                  showCheck: true,
                ),
              ),

              Positioned(
                top: y(423),
                left: x(30),
                width: x(318),
                height: y(25),
                child: const _PasswordLine(),
              ),

              Positioned(
                top: y(462),
                left: x(205),
                width: x(150),
                height: y(18),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.montserrat(
                        fontSize: x(13),
                        fontWeight: FontWeight.w500,
                        height: 1.0,
                        letterSpacing: 0.03,
                        color: const Color.fromRGBO(255, 152, 0, 1),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: y(536),
                left: x(83),
                width: x(210),
                height: y(44),
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
                      onTap: () {
                        debugPrint('Sign Up tapped');
                      },
                      child: Center(
                        child: Text(
                          'Sign Up',
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

              Positioned(
                top: y(606),
                left: x(55),
                width: x(267),
                height: y(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
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
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                            color: Color.fromRGBO(76, 175, 80, 1),
                          ),
                        ),
                      ],
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

class _AuthInputLine extends StatelessWidget {
  const _AuthInputLine({
    required this.label,
    required this.value,
    this.showCheck = false,
  });

  final String label;
  final String value;
  final bool showCheck;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(170, 170, 170, 1),
            ),
          ),
        ),

        Positioned(
          top: 19,
          left: 0,
          child: Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(37, 65, 96, 1),
            ),
          ),
        ),

        if (showCheck)
          Positioned(
            top: 17,
            right: 0,
            child: Icon(
              Icons.check,
              size: 18,
              color: const Color.fromRGBO(76, 175, 80, 1),
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
  const _PasswordLine();

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
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(37, 65, 96, 1),
            ),
          ),
        ),

        Positioned(
          top: 0,
          right: 0,
          child: Icon(
            Icons.visibility_off,
            size: 17,
            color: const Color.fromRGBO(139, 146, 154, 1),
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
