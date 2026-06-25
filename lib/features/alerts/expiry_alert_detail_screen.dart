import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:friendly_maid_app/features/recipes/recipe_suggestions_screen.dart';

class ExpiryAlertDetailScreen extends StatelessWidget {
  const ExpiryAlertDetailScreen({super.key});

  static const double designWidth = 375;
  static const double designHeight = 812;

  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);
  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color orange = Color.fromRGBO(249, 115, 22, 1);
  static const Color red = Color.fromRGBO(239, 68, 68, 1);
  static const Color navGrey = Color.fromRGBO(107, 114, 128, 1);
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
                      ),
                    ),

                    const Positioned(
                      left: 16,
                      top: 110,
                      width: 343,
                      height: 312,
                      child: _ExpiryAlertContentAsset(),
                    ),

                    Positioned(
                      left: 0,
                      top: 703,
                      width: 375,
                      height: 81,
                      child: _BottomNavBar(
                        onHomeTap: () {
                          Navigator.maybePop(context);
                        },
                        onInventoryTap: () {
                          Navigator.maybePop(context);
                        },
                        onAlertsTap: () {
                          Navigator.maybePop(context);
                        },
                        onMenuTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Menu clicked')),
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
  const _TopNav({required this.onBackTap});

  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: ExpiryAlertDetailScreen.borderGrey,
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
              'Notifications',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ExpiryAlertDetailScreen.darkText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.onHomeTap,
    required this.onInventoryTap,
    required this.onAlertsTap,
    required this.onMenuTap,
  });

  final VoidCallback onHomeTap;
  final VoidCallback onInventoryTap;
  final VoidCallback onAlertsTap;
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: ExpiryAlertDetailScreen.borderGrey, width: 1),
        ),
      ),
      child: Row(
        children: [
          _NavItem(
            icon: Icons.home_rounded,
            label: 'Home',
            active: false,
            onTap: onHomeTap,
          ),
          _NavItem(
            icon: Icons.inventory_2_rounded,
            label: 'Inventory',
            active: false,
            onTap: onInventoryTap,
          ),
          _NavItem(
            icon: Icons.notifications_rounded,
            label: 'Alerts',
            active: true,
            showBadge: true,
            onTap: onAlertsTap,
          ),
          _NavItem(
            icon: Icons.menu_rounded,
            label: 'Menu',
            active: false,
            onTap: onMenuTap,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
    this.showBadge = false,
  });

  final IconData icon;
  final String label;
  final bool active;
  final bool showBadge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active
        ? ExpiryAlertDetailScreen.green
        : ExpiryAlertDetailScreen.navGrey;

    return Expanded(
      child: _Clickable(
        onTap: onTap,
        child: SizedBox(
          height: 81,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(icon, size: 23, color: color),
                  if (showBadge)
                    Positioned(
                      right: -8,
                      top: -8,
                      child: Container(
                        width: 16,
                        height: 16,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: ExpiryAlertDetailScreen.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '3',
                          style: GoogleFonts.montserrat(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: color,
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

class _ExpiryAlertContentAsset extends StatelessWidget {
  const _ExpiryAlertContentAsset();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/expiry_alert_detail_content.png',
          width: 343,
          height: 312,
          fit: BoxFit.fill,
        ),

        // Suggests recipes
        // Suggests recipes
        Positioned(
          left: 20,
          top: 137,
          width: 303,
          height: 36,
          child: _Clickable(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RecipeSuggestionsScreen(),
                ),
              );
            },
            child: const SizedBox.expand(),
          ),
        ),
        // Add to Shopping List
        Positioned(
          left: 20,
          top: 183,
          width: 303,
          height: 36,
          child: _Clickable(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to shopping list')),
              );
            },
            child: const SizedBox.expand(),
          ),
        ),

        // Snooze
        Positioned(
          left: 20,
          top: 235,
          width: 143,
          height: 36,
          child: _Clickable(
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Alert snoozed')));
            },
            child: const SizedBox.expand(),
          ),
        ),

        // Dismiss
        Positioned(
          left: 180,
          top: 235,
          width: 143,
          height: 36,
          child: _Clickable(
            onTap: () {
              Navigator.maybePop(context);
            },
            child: const SizedBox.expand(),
          ),
        ),
      ],
    );
  }
}
