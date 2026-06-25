import 'package:flutter/material.dart';
import 'package:friendly_maid_app/features/menu/other_products_screen.dart';

class BuyNowScreen extends StatelessWidget {
  const BuyNowScreen({super.key});

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
                  'assets/buy_now_full.png',
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
                // More button
                Positioned(
                  left: 326,
                  top: 44,
                  width: 49,
                  height: 53,
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

                // Search bar click area
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

                // Filter icon area
                Positioned(
                  left: 330,
                  top: 153,
                  width: 30,
                  height: 35,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Filter clicked')),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // 1. Buy Now button
                Positioned(
                  left: 244,
                  top: 236,
                  width: 100,
                  height: 44,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Amazon item selected')),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // 2. Buy Now button
                Positioned(
                  left: 244,
                  top: 365,
                  width: 100,
                  height: 44,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Walmart item selected')),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // 3. Buy Now button
                Positioned(
                  left: 244,
                  top: 494,
                  width: 100,
                  height: 44,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Instacart item selected'),
                        ),
                      );
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // 4. Buy Now button
                Positioned(
                  left: 244,
                  top: 623,
                  width: 100,
                  height: 44,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Amazon item selected')),
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
