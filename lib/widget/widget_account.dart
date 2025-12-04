// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountProduct extends StatelessWidget {
  final String path;
  final String name;

  const AccountProduct({super.key, required this.path, required this.name});

  @override
  Widget build(BuildContext context) {
    String imgname = "assets/svgs/$path.svg";

    return InkWell(
      splashColor: Colors.grey.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.15),      
      onTap: () {
        // aksi ketika ditekan
      },
      child: SizedBox(
        height: 62,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
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
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
            ),
            Spacer(),
            Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
