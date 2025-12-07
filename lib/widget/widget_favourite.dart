// ignore_for_file: deprecated_member_use

import 'package:alchemiststock/model/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteProduct extends StatelessWidget {
  final ProductModel product;

  const FavouriteProduct({super.key, required this.product});

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
                      'assets/images/product/${product.id}.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Gap(32),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '${product.quantity}${product.unit}, Price',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Text(
                              '\$${product.price}',
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
