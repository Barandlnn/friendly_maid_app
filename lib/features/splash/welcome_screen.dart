import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../onboarding/onboarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void goToOnboarding(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goToOnboarding(context);
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: 390,
              child: Column(
                children: [
                  const SizedBox(height: 92),

                  Image.asset(
                    'assets/app_logo.png',
                    width: 118,
                    height: 118,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Friendly Maid',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserratAlternates(
                      color: AppColors.primaryGreen,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      height: 1.0,
                      letterSpacing: 0.08,
                      shadows: const [
                        Shadow(
                          offset: Offset(-2, 2),
                          blurRadius: 7,
                          color: Color.fromRGBO(0, 0, 0, 0.10),
                        ),
                        Shadow(
                          offset: Offset(-9, 8),
                          blurRadius: 12,
                          color: Color.fromRGBO(0, 0, 0, 0.09),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: 290,
                    child: Text(
                      'Smart Food Management for Your\nHome',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserratAlternates(
                        color: const Color.fromRGBO(37, 65, 96, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        height: 1.0,
                        letterSpacing: 0.03,
                      ),
                    ),
                  ),

                  Image.asset(
                    'assets/splash_food_1.png',
                    width: 360,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
