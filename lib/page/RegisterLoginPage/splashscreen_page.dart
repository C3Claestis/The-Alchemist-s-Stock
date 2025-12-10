// ignore_for_file: use_build_context_synchronously

import 'package:alchemiststock/page/RegisterLoginPage/onboarding_page.dart';
import 'package:alchemiststock/services/_mainNavigationPage.dart';
import 'package:alchemiststock/page/RegisterLoginPage/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashscreenPage extends StatelessWidget {
  const SplashscreenPage({super.key});

  Future<void> _checkLoginFlow(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2)); // delay splash animasi

    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool("onboarding_done") ?? false;
    final user = FirebaseAuth.instance.currentUser;

    // 1️⃣ Jika onboarding belum selesai → ke halaman onboarding
    if (!onboardingDone) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingPage()),
      );
      return;
    }

    // 2️⃣ Jika user sudah login → langsung ke Home
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationPage()),
      );
      return;
    }

    // 3️⃣ Jika onboarding selesai tapi user belum login → ke Signin
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SigninPage()),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    // Jalankan cek login setelah build
    Future.microtask(() => _checkLoginFlow(context));

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
