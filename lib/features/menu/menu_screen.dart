import 'package:flutter/material.dart';
import 'package:friendly_maid_app/features/menu/other_products_screen.dart';
import 'package:friendly_maid_app/features/menu/logout_screen.dart';
import 'package:friendly_maid_app/features/menu/delete_account_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  static const double designWidth = 375;
  static const double designHeight = 812;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: designWidth,
            height: designHeight,
            child: Stack(
              children: [
                Image.asset(
                  'assets/menu_full.png',
                  width: designWidth,
                  height: designHeight,
                  fit: BoxFit.fill,
                ),

                Positioned(
                  left: 0,
                  top: 44,
                  width: 64,
                  height: 53,
                  child: _Clickable(
                    onTap: () => Navigator.maybePop(context),
                    child: const SizedBox.expand(),
                  ),
                ),

                Positioned(
                  left: 16,
                  top: 278,
                  width: 343,
                  height: 60,
                  child: _Clickable(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OtherProductsScreen(),
                        ),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Log out row -> Page 30
                Positioned(
                  left: 16,
                  top: 608,
                  width: 343,
                  height: 60,
                  child: _Clickable(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LogoutScreen()),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Delete Account row -> Page 31
                Positioned(
                  left: 16,
                  top: 668,
                  width: 343,
                  height: 60,
                  child: _Clickable(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DeleteAccountScreen(),
                        ),
                      );
                    },
                    child: const SizedBox.expand(),
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

class _Clickable extends StatelessWidget {
  const _Clickable({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
