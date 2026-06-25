import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'smart_shopping_screen.dart';

class HomeManagementScreen extends StatelessWidget {
  const HomeManagementScreen({super.key});

  void _skipOnboarding(BuildContext context) {
    debugPrint('HOME MANAGEMENT TAP ÇALIŞTI');

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SmartShoppingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Figma frame genişliği 375 gibi çalışıyor.
    // Chrome penceresi geniş olsa bile tasarımı 375px alanda tutuyoruz.
    final double frameWidth = screenWidth > 420 ? 375 : screenWidth;
    final double scale = frameWidth / 375;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _skipOnboarding(context),
        child: Center(
          child: SizedBox(
            width: frameWidth,
            height: double.infinity,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned(
                  left: -72 * scale,
                  bottom: 0,
                  child: Image.asset(
                    'assets/onboarding_home_food.png',
                    width: 459 * scale,
                    height: 812 * scale,
                    fit: BoxFit.cover,
                  ),
                ),

                SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 24,
                          right: 24,
                          child: GestureDetector(
                            onTap: () => _skipOnboarding(context),
                            child: Text(
                              'Skip',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 125,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/app_logo.png',
                                width: 95,
                                height: 95,
                                fit: BoxFit.contain,
                              ),

                              const SizedBox(height: 12),

                              Text(
                                'Friendly Maid',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserratAlternates(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  height: 1.0,
                                  color: const Color.fromRGBO(76, 175, 80, 1),
                                  shadows: const [
                                    Shadow(
                                      offset: Offset(-2, 2),
                                      blurRadius: 7,
                                      color: Color.fromRGBO(0, 0, 0, 0.18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: 335,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Text(
                                'Efficient Home Management',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  height: 1.0,
                                  color: const Color.fromRGBO(37, 65, 96, 1),
                                ),
                              ),

                              const SizedBox(height: 16),

                              SizedBox(
                                width: 280,
                                child: Text(
                                  'It streamlines household management\nwith automation',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1.0,
                                    letterSpacing: 0.03,
                                    color: const Color.fromRGBO(37, 65, 96, 1),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 24),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  _OnboardingDot(isActive: false),
                                  SizedBox(width: 8),
                                  _OnboardingDot(isActive: true),
                                  SizedBox(width: 8),
                                  _OnboardingDot(isActive: false),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingDot extends StatelessWidget {
  final bool isActive;

  const _OnboardingDot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 14 : 8,
      height: 4,
      decoration: BoxDecoration(
        color: isActive
            ? const Color.fromRGBO(92, 106, 122, 1)
            : const Color.fromRGBO(178, 190, 202, 1),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
