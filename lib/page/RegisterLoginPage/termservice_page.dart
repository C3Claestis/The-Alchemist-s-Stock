import 'package:alchemiststock/widget/widget_template_sigin.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class TermservicePage extends StatelessWidget {
  const TermservicePage({super.key});

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
                  children: [Image.asset('assets/images/Chixia_sticker.png', height: 240,)],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Term of Service',
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
