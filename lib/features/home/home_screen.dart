import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../inventory/inventory_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const double figmaWidth = 375;
  static const double figmaHeight = 812;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: figmaWidth,
            height: figmaHeight,
            child: Stack(
              children: const [
                _StatusBar(),
                _PageTitle(),
                _DeviceConnectedCard(),
                _InventoryOverviewHeader(),
                _InventoryBoardImage(),
                _AddAndScanButtons(),
                _SmartRecipeButton(),
                _AttentionTitle(),
                _AttentionCard(),
                _BottomNavBar(),
                _HomeIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      width: 375,
      height: 44,
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 24, top: 10),
        child: Row(
          children: [
            Text(
              '9:41',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            const Icon(Icons.signal_cellular_alt_rounded, size: 16),
            const SizedBox(width: 4),
            const Icon(Icons.wifi_rounded, size: 16),
            const SizedBox(width: 6),
            Container(
              width: 20,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle();

  static const Color titleColor = Color.fromRGBO(37, 65, 96, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 134,
      top: 55,
      width: 107,
      height: 17,
      child: Text(
        'Friendly Maid',
        textAlign: TextAlign.center,
        style: GoogleFonts.montserratAlternates(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          height: 1,
          letterSpacing: 0.08,
          color: titleColor,
        ),
      ),
    );
  }
}

class _DeviceConnectedCard extends StatelessWidget {
  const _DeviceConnectedCard();

  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color textColor = Color.fromRGBO(55, 65, 81, 1);
  static const Color cardBg = Color.fromRGBO(243, 244, 246, 1);
  static const Color closeColor = Color.fromRGBO(107, 114, 128, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 83,
      width: 343,
      height: 48,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            const Icon(Icons.link_rounded, color: green, size: 26),
            const SizedBox(width: 14),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'XJ2389 ',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const TextSpan(text: 'Device Connected'),
                  ],
                ),
              ),
            ),
            Container(
              width: 32,
              height: 20,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.close_rounded, color: closeColor, size: 22),
          ],
        ),
      ),
    );
  }
}

class _InventoryOverviewHeader extends StatelessWidget {
  const _InventoryOverviewHeader();

  static const Color bg = Color.fromRGBO(243, 244, 246, 1);
  static const Color textColor = Color.fromRGBO(75, 85, 99, 1);
  static const Color titleColor = Color.fromRGBO(55, 65, 81, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 141,
      width: 343,
      height: 36,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(4),
        ),
        child: RichText(
          text: TextSpan(
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            children: [
              TextSpan(
                text: 'Inventory Overview ',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: titleColor,
                ),
              ),
              const TextSpan(text: '(6 items)'),
            ],
          ),
        ),
      ),
    );
  }
}

class _InventoryBoardImage extends StatelessWidget {
  const _InventoryBoardImage();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 25,
      top: 184,
      width: 325,
      height: 335,
      child: Image.asset(
        'assets/home_inventory_items.png',
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            alignment: Alignment.center,
            color: const Color.fromRGBO(250, 255, 250, 1),
            child: const Text(
              'home_inventory_items.png bulunamadı',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          );
        },
      ),
    );
  }
}

class _AddAndScanButtons extends StatelessWidget {
  const _AddAndScanButtons();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 23,
      top: 534,
      width: 330,
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: _OutlineActionButton(
              icon: Icons.add_rounded,
              label: 'Add Item',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _OutlineActionButton(
              icon: Icons.camera_alt_rounded,
              label: 'Scan',
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlineActionButton extends StatelessWidget {
  const _OutlineActionButton({required this.icon, required this.label});

  final IconData icon;
  final String label;

  static const Color green = Color.fromRGBO(76, 175, 80, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: green, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: green, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: green,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmartRecipeButton extends StatelessWidget {
  const _SmartRecipeButton();

  static const Color green = Color.fromRGBO(76, 175, 80, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 23,
      top: 584,
      width: 330,
      height: 44,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: green,
          borderRadius: BorderRadius.circular(23),
        ),
        child: Text(
          'Smart Recipe Suggestions 🍽️',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _AttentionTitle extends StatelessWidget {
  const _AttentionTitle();

  static const Color orange = Color.fromRGBO(255, 140, 0, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 23,
      top: 641,
      child: Text(
        'Attention!',
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: orange,
        ),
      ),
    );
  }
}

class _AttentionCard extends StatelessWidget {
  const _AttentionCard();

  static const Color orange = Color.fromRGBO(255, 140, 0, 1);
  static const Color textColor = Color.fromRGBO(75, 85, 99, 1);
  static const Color bg = Color.fromRGBO(255, 247, 237, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 23,
      top: 673,
      width: 330,
      height: 54,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: orange, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "There is an unusual change in the refrigerator's\ntemperature.",
                style: GoogleFonts.montserrat(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  static const Color borderColor = Color.fromRGBO(228, 231, 236, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 733,
      width: 375,
      height: 79,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: borderColor, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const _NavItem(
              icon: Icons.home_rounded,
              label: 'Home',
              selected: true,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InventoryScreen(),
                    ),
                  );
                },
                child: const _NavItem(
                  icon: Icons.inventory_2_rounded,
                  label: 'Inventory',
                ),
              ),
            ),
            const _NavItem(
              icon: Icons.notifications_rounded,
              label: 'Alerts',
              badge: '3',
            ),
            const _NavItem(icon: Icons.menu_rounded, label: 'Menu'),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.badge,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final String? badge;

  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color grey = Color.fromRGBO(107, 114, 128, 1);
  static const Color red = Color.fromRGBO(239, 68, 68, 1);

  @override
  Widget build(BuildContext context) {
    final Color activeColor = selected ? green : grey;

    return SizedBox(
      width: 72,
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, size: 25, color: activeColor),
              if (badge != null)
                Positioned(
                  right: -8,
                  top: -9,
                  child: Container(
                    width: 17,
                    height: 17,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      badge!,
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
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: activeColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 125,
      top: 801,
      width: 125,
      height: 5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
