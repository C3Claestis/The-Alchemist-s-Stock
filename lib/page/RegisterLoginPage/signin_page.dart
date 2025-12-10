// ignore_for_file: use_build_context_synchronously

import 'package:alchemiststock/page/RegisterLoginPage/enternumber_page.dart';
import 'package:alchemiststock/page/RegisterLoginPage/selectlocation_page.dart';
import 'package:alchemiststock/services/_PhoneController.dart';
import 'package:alchemiststock/services/_google_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/img.png'),
          const Gap(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerTxt(),
                const Gap(30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            EnternumberPage(controller: PhoneController()),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFE2E2E2), width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset(
                            'assets/svgs/id.svg',
                            height: 24,
                            width: 24,
                          ),
                        ),
                        Text(
                          '+62',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(40),
                _sosmedConnectTxt(),
                const Gap(38),
                _googleButton(context),
                const Gap(20),
                _fbButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _sosmedConnectTxt() {
    return SizedBox(
      width: double.infinity,
      child: Text(
        "Or connect with social media",
        style: GoogleFonts.poppins(fontSize: 11),
        textAlign: TextAlign.center,
      ),
    );
  }

  Text _headerTxt() {
    return Text(
      "Get your groceries \nwith Alchemist's Store",
      style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w600),
    );
  }

  ElevatedButton _fbButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4A66AC),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        minimumSize: const Size(353, 67),
      ),
      child: Row(
        children: [
          // ICON DI KIRI
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: SvgPicture.asset('assets/svgs/fb.svg', width: 12),
          ),

          // TEKS DI TENGAH (pakai Expanded + Center)
          Expanded(
            child: Center(
              child: Text(
                'Continue with Google',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // KOTAK KOSONG untuk menyeimbangkan icon kiri
          const SizedBox(width: 12 + 22), // ukuran icon + padding
        ],
      ),
    );
  }

  ElevatedButton _googleButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final auth = GoogleAuthService();
        final user = await auth.signInWithGoogle();

        if (user != null) {
          await auth.saveUserInfo(user);
          // Berhasil Login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => SelectlocationPage(),
            ), // arahkan ke home
          );
        } else {
          // gagal atau user batal
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Google dibatalkan atau gagal")),
          );
        }
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF5383EC),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        minimumSize: const Size(353, 67),
      ),
      child: Row(
        children: [
          // ICON DI KIRI
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SvgPicture.asset('assets/svgs/google.svg', width: 24),
          ),

          // TEKS DI TENGAH (pakai Expanded + Center)
          Expanded(
            child: Center(
              child: Text(
                'Continue with Google',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // KOTAK KOSONG untuk menyeimbangkan icon kiri
          const SizedBox(width: 24 + 16), // ukuran icon + padding
        ],
      ),
    );
  }
}
