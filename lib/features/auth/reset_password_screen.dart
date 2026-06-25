import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/home_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                width: x(148),
                height: y(68),
                child: Text(
                  'Reset\nPassword',
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
                child: const _NewPasswordLine(),
              ),

              Positioned(
                top: y(334),
                left: x(30),
                width: x(318),
                height: y(46),
                child: const _ConfirmPasswordLine(),
              ),

              Positioned(
                top: y(504),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Save',
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
                top: y(574),
                left: x(60),
                width: x(256),
                height: y(20),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      debugPrint('Sign up tapped');
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

class _NewPasswordLine extends StatelessWidget {
  const _NewPasswordLine();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            'New Password',
            style: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(170, 170, 170, 1),
            ),
          ),
        ),

        Positioned(
          top: 24,
          left: 0,
          child: Row(
            children: List.generate(
              6,
              (index) => Container(
                margin: const EdgeInsets.only(right: 8),
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(41, 53, 68, 1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),

        const Positioned(
          top: 20,
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

class _ConfirmPasswordLine extends StatelessWidget {
  const _ConfirmPasswordLine();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            'Confirm Password',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(37, 65, 96, 1),
            ),
          ),
        ),

        const Positioned(
          top: 0,
          right: 0,
          child: Icon(
            Icons.visibility_off,
            size: 17,
            color: Color.fromRGBO(139, 146, 154, 1),
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
