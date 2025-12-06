// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class BatchProduct extends StatelessWidget {
  final String title;
  final String img;
  final Color coloring;

  const BatchProduct({
    super.key,
    required this.title,
    required this.img,
    required this.coloring,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: coloring.withOpacity(0.3),
      highlightColor: coloring.withOpacity(0.15),
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        // aksi ketika ditekan
      },
      child: Container(
        width: 175,
        height: 190,
        decoration: BoxDecoration(
          color: coloring.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: coloring, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset(img, fit: BoxFit.contain),
              ),
            ),

            const Gap(20),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
