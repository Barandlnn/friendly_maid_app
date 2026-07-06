import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../auth/auth_gate.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  static const double designWidth = 375;
  static const double designHeight = 812;

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  final AuthService _authService = AuthService();

  bool _isLoggingOut = false;

  Future<void> _handleLogout() async {
    if (_isLoggingOut) return;

    setState(() {
      _isLoggingOut = true;
    });

    try {
      await _authService.signOut();

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Logged out successfully')));

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AuthGate()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      final message = e.toString().replaceFirst('Exception: ', '');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message.isEmpty ? 'Logout failed. Please try again.' : message,
          ),
        ),
      );

      setState(() {
        _isLoggingOut = false;
      });
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
            width: LogoutScreen.designWidth,
            height: LogoutScreen.designHeight,
            child: Stack(
              children: [
                Image.asset(
                  'assets/logout_full.png',
                  width: LogoutScreen.designWidth,
                  height: LogoutScreen.designHeight,
                  fit: BoxFit.fill,
                ),

                // Back button
                Positioned(
                  left: 0,
                  top: 44,
                  width: 64,
                  height: 53,
                  child: _Clickable(
                    onTap: _isLoggingOut
                        ? () {}
                        : () {
                            Navigator.maybePop(context);
                          },
                    child: const SizedBox.expand(),
                  ),
                ),

                // Log out button
                Positioned(
                  left: 16,
                  top: 718,
                  width: 343,
                  height: 44,
                  child: _Clickable(
                    onTap: _isLoggingOut ? () {} : _handleLogout,
                    child: const SizedBox.expand(),
                  ),
                ),

                // Upper blurred/empty area close action
                Positioned(
                  left: 0,
                  top: 0,
                  width: 375,
                  height: 421,
                  child: _Clickable(
                    onTap: _isLoggingOut
                        ? () {}
                        : () {
                            Navigator.maybePop(context);
                          },
                    child: const SizedBox.expand(),
                  ),
                ),

                if (_isLoggingOut)
                  Positioned.fill(
                    child: Container(
                      color: Colors.white.withValues(alpha: 0.35),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(76, 175, 80, 1),
                        ),
                      ),
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
