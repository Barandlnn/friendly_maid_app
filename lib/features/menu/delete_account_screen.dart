import 'package:flutter/material.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

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
                  'assets/delete_account_full.png',
                  width: designWidth,
                  height: designHeight,
                  fit: BoxFit.fill,
                ),

                // Üst bulanık alana veya back alanına basınca geri dönsün
                Positioned(
                  left: 0,
                  top: 0,
                  width: 375,
                  height: 421,
                  child: _Clickable(
                    onTap: () {
                      Navigator.maybePop(context);
                    },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Delete account button
                Positioned(
                  left: 16,
                  top: 718,
                  width: 343,
                  height: 44,
                  child: _Clickable(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account deleted')),
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
