// ignore_for_file: deprecated_member_use

import 'package:alchemiststock/services/_mainNavigationPage.dart';
import 'package:alchemiststock/widget/widget_template_sigin.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdercompletePage extends StatelessWidget {
  const OrdercompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateSigin(
      child: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset(
                    'assets/images/order_complete.png',
                    height: 270,
                    width: 270,
                  ),
                ),
                const Gap(60),
                Text(
                  'Your Order has been \n accepted',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                Text(
                  "Your items has been placced and is on\n it's way to being processed",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(40),
                _btnTrackOrder(context),
                const Gap(20),
                _btnBack(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _btnTrackOrder(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainNavigationPage()),
          (Route<dynamic> route) => false, // Hapus semua route
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF53B175),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        minimumSize: const Size(353, 67),
      ),
      child: Text(
        'Track Order',
        style: GoogleFonts.urbanist(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ElevatedButton _btnBack(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainNavigationPage()),
          (Route<dynamic> route) => false, // Hapus semua route
        );
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          Colors.transparent,
        ), // hilangkan splash
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      child: Text(
        'Place Order',
        style: GoogleFonts.urbanist(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
