import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../home/home_screen.dart';
import '../splash/logo_splash_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  static final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authService.authStateChanges,
      builder: (context, snapshot) {
        // Firebase kullanıcı durumunu kontrol ederken kısa loading ekranı.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _AuthLoadingScreen();
        }

        // Kullanıcı giriş yapmışsa direkt HomeScreen'e gider.
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Kullanıcı giriş yapmamışsa mevcut başlangıç akışına döner.
        return const LogoSplashScreen();
      },
    );
  }
}

class _AuthLoadingScreen extends StatelessWidget {
  const _AuthLoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(color: Color.fromRGBO(76, 175, 80, 1)),
      ),
    );
  }
}
