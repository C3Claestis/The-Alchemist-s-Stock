// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteProduct extends StatelessWidget {
  const FavouriteProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.15),     
      onTap: () {
        // aksi ketika ditekan
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 12),
        child: SizedBox(
          width: double.infinity,
          height: 115,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: Image.asset(
                      'assets/images/product/peti.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Gap(32),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Chisasa',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '\n1pcs, Price',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey.shade700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Text(
                              '\$4.99',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 16,
                            color: Colors.black87,
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
      ),
    );
  }
}
