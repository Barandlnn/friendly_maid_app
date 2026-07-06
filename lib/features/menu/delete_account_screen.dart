import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../auth/auth_gate.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  static const double designWidth = 375;
  static const double designHeight = 812;

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final AuthService _authService = AuthService();

  bool _isDeleting = false;

  Future<void> _deleteAccount() async {
    if (_isDeleting) return;

    setState(() {
      _isDeleting = true;
    });

    try {
      await _authService.deleteAccount();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account deleted successfully')),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AuthGate()),
        (route) => false,
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_authService.getErrorMessage(error))),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: DeleteAccountScreen.designWidth,
            height: DeleteAccountScreen.designHeight,
            child: Stack(
              children: [
                Image.asset(
                  'assets/delete_account_full.png',
                  width: DeleteAccountScreen.designWidth,
                  height: DeleteAccountScreen.designHeight,
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
                      if (_isDeleting) return;
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
                    onTap: _deleteAccount,
                    child: _isDeleting
                        ? const Center(
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : const SizedBox.expand(),
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
