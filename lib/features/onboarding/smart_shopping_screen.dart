import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/sign_up_screen.dart';

class SmartShoppingScreen extends StatefulWidget {
  const SmartShoppingScreen({super.key});

  @override
  State<SmartShoppingScreen> createState() => _SmartShoppingScreenState();
}

class _SmartShoppingScreenState extends State<SmartShoppingScreen> {
  final FocusNode _focusNode = FocusNode();

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignUpScreen()),
    );
  }

  void _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.space ||
        key == LogicalKeyboardKey.arrowRight ||
        key == LogicalKeyboardKey.arrowDown) {
      _finishOnboarding();
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    final sx = screen.width / 375;
    final sy = screen.height / 812;

    double x(double value) => value * sx;
    double y(double value) => value * sy;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      body: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKey,
        child: SizedBox.expand(
          child: Stack(
            children: [
              // Poşet resmi
              Positioned(
                left: x(-129),
                top: y(-357),
                width: x(924.58),
                height: y(1585),
                child: IgnorePointer(
                  child: Image.asset(
                    'assets/onboarding_smart_shopping.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                left: x(164),
                top: y(533),
                width: x(27),
                height: y(32),
                child: Transform.rotate(
                  angle: -6 * 3.14159 / 180,
                  child: Image.asset(
                    'assets/app_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Positioned(
                top: y(118),
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/app_logo.png',
                      width: x(76),
                      height: y(86),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: y(8)),
                    Text(
                      'Friendly Maid',
                      style: GoogleFonts.montserratAlternates(
                        fontSize: x(17),
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF47B84D),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: y(332),
                left: 0,
                right: 0,
                child: Text(
                  'Smart Shopping Assistance',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserratAlternates(
                    fontSize: x(20),
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF254160),
                  ),
                ),
              ),

              Positioned(
                top: y(370),
                left: x(42),
                right: x(42),
                child: Text(
                  'The app simplifies shopping with smart\nsuggestions',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserratAlternates(
                    fontSize: x(13),
                    fontWeight: FontWeight.w400,
                    height: 1.15,
                    color: const Color(0xFF254160),
                  ),
                ),
              ),

              Positioned(
                top: y(417),
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Dot(color: const Color(0xFFB7C0C8), width: x(9)),
                    SizedBox(width: x(5)),
                    _Dot(color: const Color(0xFFB7C0C8), width: x(9)),
                    SizedBox(width: x(5)),
                    _Dot(color: const Color(0xFF6E7E8E), width: x(13)),
                  ],
                ),
              ),

              Positioned(
                left: x(98),
                right: x(88),
                bottom: y(59),
                height: y(40),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFF48B84E),
                    borderRadius: BorderRadius.circular(x(22)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        offset: Offset(0, y(5)),
                        blurRadius: x(10),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(x(22)),
                      onTap: _finishOnboarding,
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.montserratAlternates(
                            fontSize: x(14),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

class _Dot extends StatelessWidget {
  const _Dot({required this.color, required this.width});

  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 4,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }
}

class TemporaryHomeScreen extends StatelessWidget {
  const TemporaryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      body: Center(
        child: Text(
          'Home Screen',
          style: GoogleFonts.montserratAlternates(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF254160),
          ),
        ),
      ),
    );
  }
}
