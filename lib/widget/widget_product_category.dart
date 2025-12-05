// ignore_for_file: deprecated_member_use

import 'package:alchemiststock/model/category.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCategory extends StatelessWidget {
  final CategoryModel category;
  final Color color;

  const ProductCategory({super.key, required this.category, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      height: 105,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),             
        color: color.withOpacity(0.3),
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
                  image: AssetImage('assets/images/batch/${category.name}.png'),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),            
            const Gap(14),
            Expanded(
              child: Text(
                category.name,
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