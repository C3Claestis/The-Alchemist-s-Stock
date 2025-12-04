// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 12),
      child: SizedBox(
        width: double.infinity,
        height: 126,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 72,
                      height: 72,
                      child: Image.asset(
                        'assets/images/product/Ilu.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                const Gap(32),
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: _headerNameProduct(),
                        ),
                        const Gap(6),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: _countItem(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Divider(height: 1),
          ],
        ),
      ),
    );
  }

  Row _headerNameProduct() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Chisasa',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: '\n1pcs, Price',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Color(0xFF7C7C7C),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/svgs/cancel.svg',
            height: 16,
            width: 16,
          ),
        ),
      ],
    );
  }

  Row _countItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // BOX UNTUK TOMBOL MINUS
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.remove, size: 22),
                onPressed: () {},
              ),
            ),

            const SizedBox(width: 12),

            // ANGKA TANPA BOX
            Text(
              '1',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(width: 12),

            // BOX UNTUK TOMBOL PLUS
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.add, size: 22, color: Color(0xFF53B175)),
                onPressed: () {},
              ),
            ),
          ],
        ),

        // Harga di kanan
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(
            '\$4.99',
            style: GoogleFonts.roboto(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
