// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:alchemiststock/services/_CustomExpand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductdetailPage extends StatefulWidget {
  const ProductdetailPage({super.key});

  @override
  State<ProductdetailPage> createState() => _ProductdetailPageState();
}

class _ProductdetailPageState extends State<ProductdetailPage> {
  String description =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imageProduct("assets/images/product/peti.png"),
            const Gap(18),
            _headerNameProduct(),
            const Gap(18),
            _countItem(),
            const Gap(18),
            _garisPembatas(),
            const Gap(18),
            _productDetail(),
            const Gap(8),
            _garisPembatas(),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomExpand(
                tittle: "Lore",
                description: description,
                type: ExpandType.lore,
              ),
            ),
            const Gap(8),
            _garisPembatas(),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomExpand(
                tittle: "Review",
                description: description,
                type: ExpandType.review,
              ),
            ),
            const Gap(20),
            _buttonSubmit(context),
            const Gap(24),
          ],
        ),
      ),
    );
  }

  Padding _productDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomExpand(
        tittle: "Product Detail",
        description: description,
        type: ExpandType.normal,
      ),
    );
  }

  Stack _imageProduct(String path) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 372,
          decoration: BoxDecoration(
            color: Color(0xFFF2F3F2),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
        ),

        /// --- SHADOW / BLUR dari gambar utama ---
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: Center(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Opacity(
                opacity: 0.45, // biar shadow lembut
                child: Image.asset(
                  path,
                  width: 220,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),

        /// --- GAMBAR UTAMA ---
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: Center(child: Image.asset(path, width: 240, height: 240)),
        ),

        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/svgs/upload.svg',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding _headerNameProduct() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Chisasa',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
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
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/svgs/heart.svg'),
          ),
        ],
      ),
    );
  }

  Padding _countItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.remove, size: 28)),
              Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  '1',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add, color: Color(0xFF53B175), size: 28),
              ),
            ],
          ),
          Text(
            '\$4.99',
            style: GoogleFonts.roboto(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Divider _garisPembatas() {
    return Divider(
      thickness: 1,
      color: Colors.grey.shade300,
      indent: 25,
      endIndent: 25,
    );
  }

  ElevatedButton _buttonSubmit(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (_) => const ),
        // );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF53B175),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        minimumSize: const Size(353, 67),
      ),
      child: Text(
        'Add To Basket',
        style: GoogleFonts.urbanist(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
