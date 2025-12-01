import 'package:alchemiststock/page/enternumber_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                Text(
                  "Get your groceries \nwith Alchemist's Store",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EnternumberPage()),
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
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.flag,
                              color: Color(0xFF7C7C7C), size: 24),
                        ),
                        Text(
                          '+62',
                          style:
                              const TextStyle(color: Color(0xFF7C7C7C), fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(40),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Or connect with social media",
                    style: GoogleFonts.poppins(fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(38),
                _googleButton(),
                const Gap(20),
                _fbButton(),
              ],
            ),
          ),
        ],
      ),
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

  ElevatedButton _googleButton() {
    return ElevatedButton(
      onPressed: () {},
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


