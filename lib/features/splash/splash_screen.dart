import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 390,
            child: Column(
              children: [
                const Spacer(flex: 3),

                Image.asset('assets/app_logo.png', width: 90, height: 90),

                const SizedBox(height: 14),

                const Text(
                  'Friendly Maid',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Smart Food Management for\nyour Home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.subtitleGrey,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),

                const Spacer(flex: 2),

                Image.asset(
                  'assets/splash_food_1.png',
                  width: 330,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
