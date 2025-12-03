// ignore_for_file: file_names

import 'package:alchemiststock/widget/widget_template_sigin.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacypolicyPage extends StatelessWidget {
  const PrivacypolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateSigin(
      child: Stack(
        children: [
          // KONTEN UTAMA
          Positioned(
            top: 64,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.black,
                  ),
                ),

                const Gap(64),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.asset('assets/images/Rover_sticker.png')],
                ),                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Privacy Policy',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
