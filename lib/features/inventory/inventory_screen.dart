import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_details_screen.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  static const double figmaWidth = 375;
  static const double figmaHeight = 812;

  String selectedFilter = 'All';

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _changeFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  bool get isAllSelected => selectedFilter == 'All';
  bool get isExpiringSoonSelected => selectedFilter == 'Expiring Soon';

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
              children: [
                const _StatusBar(),

                _TopNavigation(
                  onBack: () {
                    Navigator.maybePop(context);
                  },
                ),

                _SearchAndFilters(
                  selectedFilter: selectedFilter,
                  onFilterTap: _changeFilter,
                ),

                _ItemCountText(
                  text: isExpiringSoonSelected ? '1 items' : '6 items',
                ),

                if (isAllSelected) ...[
                  const _AllInventoryItemsImage(),

                  Positioned(
                    left: 16,
                    top: 266,
                    width: 343,
                    height: 75,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProductDetailsScreen(),
                            ),
                          );
                        },
                        child: const SizedBox.expand(),
                      ),
                    ),
                  ),
                ] else if (isExpiringSoonSelected)
                  _ExpiringSoonAppleItem(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProductDetailsScreen(),
                        ),
                      );
                    },
                  ),

                if (isAllSelected)
                  _GreenButton(
                    left: 18,
                    top: 594,
                    width: 343,
                    height: 44,
                    text: '+ Add items',
                    filled: true,
                    onTap: () {
                      _showMessage(context, 'Add items clicked');
                    },
                  ),

                if (isAllSelected)
                  _GreenButton(
                    left: 17,
                    top: 646,
                    width: 343,
                    height: 44,
                    text: 'Smart Recipe Suggestions 🍽️',
                    filled: false,
                    onTap: () {
                      _showMessage(context, 'Smart Recipe Suggestions clicked');
                    },
                  ),

                _BottomNavBar(
                  onHomeTap: () {
                    Navigator.maybePop(context);
                  },
                  onInventoryTap: () {
                    _showMessage(context, 'Already on Inventory');
                  },
                  onAlertsTap: () {
                    _showMessage(context, 'Alerts clicked');
                  },
                  onMenuTap: () {
                    _showMessage(context, 'Menu clicked');
                  },
                ),

                const _HomeIndicator(),
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

class _TopNavigation extends StatelessWidget {
  const _TopNavigation({required this.onBack});

  final VoidCallback onBack;

  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 44,
      width: 375,
      height: 53,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: borderGrey, width: 1)),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              top: 0,
              width: 48,
              height: 53,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onBack,
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: darkText,
                  size: 24,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              width: 375,
              height: 53,
              child: Center(
                child: Text(
                  'Inventory',
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchAndFilters extends StatelessWidget {
  const _SearchAndFilters({
    required this.selectedFilter,
    required this.onFilterTap,
  });

  final String selectedFilter;
  final ValueChanged<String> onFilterTap;

  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);
  static const Color greyText = Color.fromRGBO(156, 163, 175, 1);
  static const Color lightGrey = Color.fromRGBO(239, 241, 244, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 98,
      width: 375,
      height: 126,
      child: Column(
        children: [
          const SizedBox(height: 30),

          Container(
            width: 343,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: borderGrey, width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: greyText, size: 24),
                const SizedBox(width: 10),
                Text(
                  'Search',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: greyText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Container(
            width: 343,
            height: 40,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _FilterChip(
                  width: 40,
                  text: 'All',
                  selected: selectedFilter == 'All',
                  onTap: () => onFilterTap('All'),
                ),
                _FilterChip(
                  width: 124,
                  text: 'Expiring Soon ⏳',
                  selected: selectedFilter == 'Expiring Soon',
                  onTap: () => onFilterTap('Expiring Soon'),
                ),
                _FilterChip(
                  width: 75,
                  text: 'Fresh 🥦',
                  selected: selectedFilter == 'Fresh',
                  onTap: () => onFilterTap('Fresh'),
                ),
                _FilterChip(
                  width: 100,
                  text: 'Beverages 🥤',
                  selected: selectedFilter == 'Beverages',
                  onTap: () => onFilterTap('Beverages'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.width,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final double width;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color greyText = Color.fromRGBO(156, 163, 175, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: width,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: selected ? Border.all(color: borderGrey, width: 1) : null,
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? darkText : greyText,
          ),
        ),
      ),
    );
  }
}

class _ItemCountText extends StatelessWidget {
  const _ItemCountText({required this.text});

  final String text;

  static const Color greyText = Color.fromRGBO(107, 114, 128, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 27,
      top: 240,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: greyText,
        ),
      ),
    );
  }
}

class _AllInventoryItemsImage extends StatelessWidget {
  const _AllInventoryItemsImage();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 266,
      width: 343,
      height: 318,
      child: Image.asset(
        'assets/inventory_page_12.png',
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color.fromRGBO(228, 231, 236, 1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'inventory_page_12.png bulunamadı',
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}

class _ExpiringSoonAppleItem extends StatelessWidget {
  const _ExpiringSoonAppleItem({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 255,
      width: 343,
      height: 75,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                left: 0,
                top: 0,
                width: 343,
                height: 318,
                child: Image.asset(
                  'assets/inventory_page_12.png',
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromRGBO(228, 231, 236, 1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'inventory_page_12.png bulunamadı',
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GreenButton extends StatelessWidget {
  const _GreenButton({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.text,
    required this.filled,
    required this.onTap,
  });

  final double left;
  final double top;
  final double width;
  final double height;
  final String text;
  final bool filled;
  final VoidCallback onTap;

  static const Color green = Color.fromRGBO(76, 175, 80, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: filled ? green : Colors.white,
            borderRadius: BorderRadius.circular(23),
            border: Border.all(color: green, width: 1),
          ),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: filled ? Colors.white : green,
            ),
          ),
        ),
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

  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 703,
      width: 375,
      height: 81,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: borderGrey, width: 1)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                selected: false,
                onTap: onHomeTap,
              ),
              _NavItem(
                icon: Icons.inventory_2_rounded,
                label: 'Inventory',
                selected: true,
                onTap: onInventoryTap,
              ),
              _NavItem(
                icon: Icons.notifications_rounded,
                label: 'Alerts',
                selected: false,
                badge: '3',
                onTap: onAlertsTap,
              ),
              _NavItem(
                icon: Icons.menu_rounded,
                label: 'Menu',
                selected: false,
                onTap: onMenuTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final String? badge;
  final VoidCallback onTap;

  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color greyText = Color.fromRGBO(107, 114, 128, 1);
  static const Color red = Color.fromRGBO(239, 68, 68, 1);

  @override
  Widget build(BuildContext context) {
    final Color activeColor = selected ? green : greyText;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 72,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: activeColor, size: 25),
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
      top: 804,
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
