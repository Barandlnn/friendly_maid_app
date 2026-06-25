import 'package:flutter/material.dart';
import 'package:friendly_maid_app/features/shopping/buy_now_screen.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({super.key});

  static const double designWidth = 375;
  static const double viewportHeight = 812;
  static const double fullContentHeight = 928;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: designWidth,
            height: viewportHeight,
            child: ClipRect(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: designWidth,
                  height: fullContentHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/recipe_details_full.png',
                        width: designWidth,
                        height: fullContentHeight,
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

                      // Heart / favorite button
                      // More button
                      Positioned(
                        left: 32,
                        top: 850,
                        width: 300,
                        height: 38,
                        child: _Clickable(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BuyNowScreen(),
                              ),
                            );
                          },
                          child: const SizedBox.expand(),
                        ),
                      ),
                      // Missing ingredient lemon area
                      Positioned(
                        left: 32,
                        top: 755,
                        width: 80,
                        height: 85,
                        child: _Clickable(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Missing ingredient selected'),
                              ),
                            );
                          },
                          child: const SizedBox.expand(),
                        ),
                      ),

                      // Buy Now button
                      Positioned(
                        left: 32,
                        top: 850,
                        width: 300,
                        height: 38,
                        child: _Clickable(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BuyNowScreen(),
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
