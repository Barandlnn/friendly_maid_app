import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_management_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _goToHomeManagementScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeManagementScreen()),
    );
  }

  void _skipOnboarding() {
    _goToHomeManagementScreen();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.enter ||
        event.logicalKey == LogicalKeyboardKey.space) {
      _goToHomeManagementScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _goToHomeManagementScreen,
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    top: 24,
                    right: 24,
                    child: GestureDetector(
                      onTap: _skipOnboarding,
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
                          'Food Waste Reduction',
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
                            'Friendly Maid reduces food waste with\nsmart tracking',
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
                            _OnboardingDot(isActive: true),
                            SizedBox(width: 8),
                            _OnboardingDot(isActive: false),
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
