// ignore_for_file: use_build_context_synchronously

import 'package:alchemiststock/page/RegisterLoginPage/onboarding_page.dart';
import 'package:alchemiststock/services/_mainNavigationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashscreenPage extends StatelessWidget {
  const SplashscreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 2));

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // SUDAH LOGIN → langsung ke home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainNavigationPage()),
        );
      } else {
        // BELUM LOGIN → ke onboarding
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingPage()),
        );
      }
    });

    return Center(
      child: Container(
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        color: const Color(0xFF53B175),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Witch_Hat.png'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Alchemist's \n Store",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "online groceries",
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
