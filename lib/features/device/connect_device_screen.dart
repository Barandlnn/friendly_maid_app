import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/home_screen.dart';

class ConnectDeviceScreen extends StatelessWidget {
  const ConnectDeviceScreen({super.key});

  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color greyText = Color.fromRGBO(107, 114, 128, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);

  void _goToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 18),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.maybePop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 26,
                      color: darkText,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 34),

              Container(
                width: 116,
                height: 116,
                decoration: BoxDecoration(
                  color: green.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Icon(
                  Icons.bluetooth_connected_rounded,
                  size: 64,
                  color: green,
                ),
              ),

              const SizedBox(height: 28),

              Text(
                'Connect Your Device',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Connect your smart kitchen devices to start tracking your inventory automatically.',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.45,
                  color: greyText,
                ),
              ),

              const SizedBox(height: 34),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bluetooth_searching_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  label: Text(
                    'Scan for Devices',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Available Devices',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              _DeviceCard(
                icon: Icons.kitchen_rounded,
                title: 'Smart Refrigerator',
                subtitle: 'Ready to pair',
                onConnect: () {
                  _goToHome(context);
                },
              ),

              const SizedBox(height: 12),

              _DeviceCard(
                icon: Icons.scale_rounded,
                title: 'Kitchen Scale',
                subtitle: 'Ready to pair',
                onConnect: () {
                  _goToHome(context);
                },
              ),

              const SizedBox(height: 12),

              _DeviceCard(
                icon: Icons.water_drop_rounded,
                title: 'Water Dispenser',
                subtitle: 'Ready to pair',
                onConnect: () {
                  _goToHome(context);
                },
              ),

              const Spacer(),

              TextButton(
                onPressed: () {
                  _goToHome(context);
                },
                child: Text(
                  'Skip for now',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: greyText,
                  ),
                ),
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onConnect,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onConnect;

  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color greyText = Color.fromRGBO(107, 114, 128, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: green.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: green, size: 28),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: greyText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: onConnect,
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                'Connect',
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
