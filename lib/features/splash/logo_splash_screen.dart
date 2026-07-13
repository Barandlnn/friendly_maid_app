import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'welcome_screen.dart';

class LogoSplashScreen extends StatefulWidget {
  const LogoSplashScreen({super.key});

  @override
  State<LogoSplashScreen> createState() => _LogoSplashScreenState();
}

class _LogoSplashScreenState extends State<LogoSplashScreen> {
  final TransformationController _controller = TransformationController();
  final FocusNode _focusNode = FocusNode();

  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    _controller.value = Matrix4.identity()
      ..translateByDouble(-320.0, -40.0, 0.0, 1.0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _goToWelcomeScreen() {
    if (_isNavigating || !mounted) return;

    setState(() {
      _isNavigating = true;
    });

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
    );
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    final LogicalKeyboardKey pressedKey = event.logicalKey;

    if (pressedKey == LogicalKeyboardKey.arrowRight ||
        pressedKey == LogicalKeyboardKey.arrowLeft ||
        pressedKey == LogicalKeyboardKey.arrowUp ||
        pressedKey == LogicalKeyboardKey.arrowDown ||
        pressedKey == LogicalKeyboardKey.enter ||
        pressedKey == LogicalKeyboardKey.space) {
      _goToWelcomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(76, 175, 80, 1),
      body: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _goToWelcomeScreen,
                child: InteractiveViewer(
                  transformationController: _controller,
                  panEnabled: true,
                  scaleEnabled: false,
                  constrained: false,
                  boundaryMargin: const EdgeInsets.all(600),
                  minScale: 1,
                  maxScale: 1,
                  child: Image.asset(
                    'assets/app_icon.png',
                    width: 1024,
                    height: 1024,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed:
                        _isNavigating ? null : _goToWelcomeScreen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor:
                          const Color.fromRGBO(76, 175, 80, 1),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
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