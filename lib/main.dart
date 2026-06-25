import 'package:flutter/material.dart';
import 'features/splash/logo_splash_screen.dart';

void main() {
  runApp(const FriendlyMaidApp());
}

class FriendlyMaidApp extends StatelessWidget {
  const FriendlyMaidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogoSplashScreen(),
    );
  }
}
