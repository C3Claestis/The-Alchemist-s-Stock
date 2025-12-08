// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountProduct extends StatelessWidget {
  final String path;
  final String name;
  final VoidCallback? onTap;

  const AccountProduct({
    super.key,
    required this.path,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String imgname = "assets/svgs/$path.svg";

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap, // Tetap bisa null
        borderRadius: BorderRadius.circular(0),
        splashColor: Colors.green.withOpacity(0.15),
        highlightColor: Colors.black.withOpacity(0.05), // Saat ditekan
        child: SizedBox(
          height: 62,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
                child: Row(
                  children: [
                    SvgPicture.asset(imgname),
                    const Gap(20),
                    Text(
                      name,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
              const Spacer(),
              const Divider(height: 1),
            ],
          ),
        ),
      ),
    );
  }
}

