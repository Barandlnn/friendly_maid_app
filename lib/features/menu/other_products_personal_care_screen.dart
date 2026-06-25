import 'package:flutter/material.dart';
import 'package:friendly_maid_app/features/menu/menu_screen.dart';

class OtherProductsPersonalCareScreen extends StatelessWidget {
  const OtherProductsPersonalCareScreen({super.key});

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
                  'assets/other_products_personal_care_full.png',
                  width: designWidth,
                  height: designHeight,
                  fit: BoxFit.fill,
                ),

                // Back button
                Positioned(
                  left: 0,
                  top: 44,
                  width: 64,
                  height: 53,
                  child: _Clickable(
                    onTap: () {
                      Navigator.maybePop(context);
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // More button
                Positioned(
                  left: 326,
                  top: 44,
                  width: 49,
                  height: 53,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('More clicked')),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Search bar
                Positioned(
                  left: 16,
                  top: 97,
                  width: 343,
                  height: 44,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Search clicked')),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Medicines tab -> geri Page 27
                Positioned(
                  left: 16,
                  top: 151,
                  width: 92,
                  height: 38,
                  child: _Clickable(
                    onTap: () {
                      Navigator.maybePop(context);
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Personal Care tab - active
                Positioned(
                  left: 108,
                  top: 151,
                  width: 120,
                  height: 38,
                  child: _Clickable(
                    onTap: () {},
                    child: const SizedBox.expand(),
                  ),
                ),

                // Garden Tools tab
                Positioned(
                  left: 228,
                  top: 151,
                  width: 131,
                  height: 38,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Garden Tools clicked')),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Face Cream item card
                Positioned(
                  left: 16,
                  top: 255,
                  width: 343,
                  height: 75,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Face Cream selected')),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Item three dots
                Positioned(
                  left: 330,
                  top: 265,
                  width: 28,
                  height: 50,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item options clicked')),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Add items button
                Positioned(
                  left: 16,
                  top: 625,
                  width: 343,
                  height: 44,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Add items clicked')),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Bottom nav - Home
                Positioned(
                  left: 0,
                  top: 703,
                  width: 94,
                  height: 81,
                  child: _Clickable(
                    onTap: () {
                      Navigator.maybePop(context);
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Bottom nav - Inventory
                Positioned(
                  left: 94,
                  top: 703,
                  width: 94,
                  height: 81,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Inventory clicked')),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Bottom nav - Alerts
                Positioned(
                  left: 188,
                  top: 703,
                  width: 94,
                  height: 81,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Alerts clicked')),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Bottom nav - Menu active
                // Bottom nav - Menu
                Positioned(
                  left: 282,
                  top: 703,
                  width: 93,
                  height: 81,
                  child: _Clickable(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MenuScreen()),
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
