import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:friendly_maid_app/features/recipes/recipe_details_screen.dart';

class RecipeSuggestionsScreen extends StatelessWidget {
  const RecipeSuggestionsScreen({super.key});

  static const double designWidth = 375;
  static const double designHeight = 812;

  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color borderGrey = Color.fromRGBO(229, 231, 235, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: designWidth,
                height: designHeight,
                child: Stack(
                  children: [
                    const Positioned(
                      left: 0,
                      top: 0,
                      width: 375,
                      height: 44,
                      child: _StatusBar(),
                    ),

                    Positioned(
                      left: 0,
                      top: 44,
                      width: 375,
                      height: 53,
                      child: _TopNav(
                        onBackTap: () {
                          Navigator.maybePop(context);
                        },
                        onMoreTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('More clicked')),
                          );
                        },
                      ),
                    ),

                    Positioned(
                      left: 0,
                      top: 97,
                      width: 375,
                      height: 687,
                      child: _RecipeSuggestionsBody(
                        onFriedShrimpTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RecipeDetailsScreen(),
                            ),
                          );
                        },
                      ),
                    ),

                    const Positioned(
                      left: 0,
                      top: 784,
                      width: 375,
                      height: 28.42,
                      child: _HomeIndicator(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            left: 26,
            top: 14,
            child: Text(
              '9:41',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),

          Positioned(
            right: 28,
            top: 14,
            child: SizedBox(
              width: 60,
              height: 14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.signal_cellular_alt_rounded,
                    size: 15,
                    color: Colors.black,
                  ),
                  Transform.translate(
                    offset: const Offset(0, 1),
                    child: const Icon(
                      Icons.wifi_rounded,
                      size: 14,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: 18,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopNav extends StatelessWidget {
  const _TopNav({required this.onBackTap, required this.onMoreTap});

  final VoidCallback onBackTap;
  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: RecipeSuggestionsScreen.borderGrey,
            width: 1,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 15,
            child: _Clickable(
              onTap: onBackTap,
              child: const Icon(
                Icons.arrow_back,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),

          Center(
            child: Text(
              'Recipe Suggestions',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: RecipeSuggestionsScreen.darkText,
              ),
            ),
          ),

          Positioned(
            right: 28,
            top: 15,
            child: _Clickable(
              onTap: onMoreTap,
              child: const Icon(
                Icons.more_horiz_rounded,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeSuggestionsBody extends StatelessWidget {
  const _RecipeSuggestionsBody({required this.onFriedShrimpTap});

  final VoidCallback onFriedShrimpTap;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: 375,
          height: 820,
          child: Stack(
            children: [
              Positioned(
                left: 26,
                top: 15,
                width: 324,
                height: 787,
                child: Image.asset(
                  'assets/recipe_suggestions_content.png',
                  width: 324,
                  height: 787,
                  fit: BoxFit.fill,
                ),
              ),

              // Fried Shrimp kartı / View Recipe alanı
              Positioned(
                left: 190,
                top: 15,
                width: 150,
                height: 230,
                child: _Clickable(
                  onTap: onFriedShrimpTap,
                  child: const SizedBox.expand(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 134,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(100),
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
