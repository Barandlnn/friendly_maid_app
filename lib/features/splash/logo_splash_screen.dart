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

  @override
  void initState() {
    super.initState();

    _controller.value = Matrix4.identity()
      ..translateByDouble(-320.0, -40.0, 0.0, 1.0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.arrowUp ||
        event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.enter ||
        event.logicalKey == LogicalKeyboardKey.space) {
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
    );
  }
}
