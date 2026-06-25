import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_new_item_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  static const double figmaWidth = 375;
  static const double figmaHeight = 812;

  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);
  static const Color lightGrey = Color.fromRGBO(229, 231, 235, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);
  static const Color red = Color.fromRGBO(239, 68, 68, 1);
  static const Color orange = Color.fromRGBO(249, 115, 22, 1);
  static const Color navy = Color.fromRGBO(30, 58, 95, 1);

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

                const _ProductHeader(),

                const _DetailsCard(),

                const _OutlineAddButton(),

                const _BuyNowButton(),

                const _SetAlertSection(),

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
            Center(
              child: Text(
                'Product details',
                style: GoogleFonts.montserrat(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductHeader extends StatelessWidget {
  const _ProductHeader();

  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);
  static const Color red = Color.fromRGBO(239, 68, 68, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 15,
      top: 112,
      width: 345,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              'assets/product_milk.png',
              width: 135,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 135,
                  height: 100,
                  alignment: Alignment.center,
                  color: const Color.fromRGBO(243, 244, 246, 1),
                  child: const Text(
                    'product_milk.png\nbulunamadı',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11),
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 10),

          SizedBox(
            width: 155,
            child: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Organic Whole Milk',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: darkText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Premium dairy product\nby meadowland farms',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.25,
                      color: greyText,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: red, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.delete_outline_rounded,
              color: red,
              size: 21,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard();

  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);
  static const Color orange = Color.fromRGBO(249, 115, 22, 1);
  static const Color green = Color.fromRGBO(76, 175, 80, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 227,
      width: 343,
      height: 345,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderGrey, width: 1),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 19, 16, 0),
              child: Column(
                children: [
                  _InfoRow(
                    label: 'Expiration Date',
                    value: 'Feb 15, 2024 (5 days left)',
                    valueColor: orange,
                  ),
                  const SizedBox(height: 19),
                  const _InfoRow(
                    label: 'Remaining Quantity',
                    value: '500ml of 1000ml',
                    valueColor: darkText,
                  ),
                  const SizedBox(height: 19),
                  const _InfoRow(
                    label: 'Storage Location',
                    value: 'Main Refrigerator',
                    valueColor: darkText,
                  ),
                  const SizedBox(height: 18),
                  Stack(
                    children: [
                      Container(
                        width: 309,
                        height: 7,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(229, 231, 235, 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Container(
                        width: 154,
                        height: 7,
                        decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            Container(width: 343, height: 1, color: borderGrey),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 25, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _InfoRow(
                    label: 'Purchase Date',
                    value: 'Feb 1, 2025',
                    valueColor: darkText,
                  ),

                  const SizedBox(height: 18),

                  Text(
                    'Notes',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: greyText,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Organic whole milk from local farm. Best served\nchilled. High in calcium and vitamin D.',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.35,
                      color: greyText,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: const [
                      _TagChip(text: 'Dairy'),
                      SizedBox(width: 8),
                      _TagChip(text: 'Organic'),
                      SizedBox(width: 8),
                      _TagChip(text: 'Refrigerated'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: greyText,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.text});

  final String text;

  static const Color chipBg = Color.fromRGBO(243, 244, 246, 1);
  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: chipBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: greyText,
        ),
      ),
    );
  }
}

class _OutlineAddButton extends StatelessWidget {
  const _OutlineAddButton();

  static const Color green = Color.fromRGBO(76, 175, 80, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 590,
      width: 343,
      height: 44,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddNewItemScreen()),
            );
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
              border: Border.all(color: green, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_rounded, color: green, size: 23),
                const SizedBox(width: 8),
                Text(
                  'Add',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: green,
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

class _BuyNowButton extends StatelessWidget {
  const _BuyNowButton();

  static const Color green = Color.fromRGBO(76, 175, 80, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 650,
      width: 343,
      height: 44,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: green,
          borderRadius: BorderRadius.circular(23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 21,
            ),
            const SizedBox(width: 8),
            Text(
              'Buy Now',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SetAlertSection extends StatelessWidget {
  const _SetAlertSection();

  static const Color navy = Color.fromRGBO(30, 58, 95, 1);
  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 27,
      top: 722,
      width: 330,
      height: 82,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Text(
              'Set alert',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: navy,
              ),
            ),
          ),

          Positioned(
            left: 0,
            top: 28,
            width: 260,
            child: Text(
              'Send me a notification when the product\ndrops below 10% of the main amount.',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.35,
                color: greyText,
              ),
            ),
          ),

          const Positioned(right: 0, top: 0, child: _SmallSwitch()),
        ],
      ),
    );
  }
}

class _SmallSwitch extends StatelessWidget {
  const _SmallSwitch();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 31,
      height: 19,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(209, 213, 219, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 15,
          height: 15,
          margin: const EdgeInsets.only(left: 2),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
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
