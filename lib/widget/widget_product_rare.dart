// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductRare extends StatelessWidget {
  const ProductRare({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      height: 105,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(color: Colors.grey.shade300, width: 1),        
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Chisa.jpeg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),            
            const Gap(14),
            Expanded(
              child: Text(
                'Chisa my bini dari dulu',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}