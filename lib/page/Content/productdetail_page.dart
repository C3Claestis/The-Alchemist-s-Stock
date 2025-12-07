// ignore_for_file: deprecated_member_use, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:ui';
import 'package:alchemiststock/model/product.dart';
import 'package:alchemiststock/services/_CustomExpand.dart';
import 'package:alchemiststock/services/_cart_service.dart';
import 'package:alchemiststock/services/_favourite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductdetailPage extends StatefulWidget {
  final ProductModel product;

  const ProductdetailPage({super.key, required this.product});

  @override
  State<ProductdetailPage> createState() => _ProductdetailPageState();
}

class _ProductdetailPageState extends State<ProductdetailPage> {
  int _count = 1;
  late bool _isFavourite;

  @override
  void initState() {
    super.initState();
    // Cek status favorit saat halaman pertama kali dibuka
    _isFavourite = FavouriteService.isFavourite(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imageProduct("assets/images/product/${widget.product.id}.png"),
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
            _lore(),
            const Gap(8),
            _garisPembatas(),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomExpand(
                tittle: "Review",
                description: widget.product.description,
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

  Padding _lore() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomExpand(
        tittle: "Lore",
        description: widget.product.lore,
        type: ExpandType.lore,
      ),
    );
  }

  Padding _productDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomExpand(
        tittle: "Product Detail",
        description: widget.product.description,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${widget.product.quantity}${widget.product.unit}, Price',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: IconButton(
              onPressed: () async {
                await FavouriteService.toggleFavourite(widget.product);

                setState(() {
                  _isFavourite = !_isFavourite;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isFavourite
                          ? "Added to favourites!"
                          : "Removed from favourites!",
                    ),
                  ),
                );
              },
              icon: SvgPicture.asset(
                'assets/svgs/heart.svg',
                color: _isFavourite ? Colors.red : null,
              ),
            ),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (_count > 1) {
                    setState(() {
                      _count--;
                    });
                  }
                },
                child: const Icon(Icons.remove, size: 28),
              ),
              const Gap(12),
              Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  '$_count',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Gap(12),
              InkWell(
                onTap: () {
                  setState(() {
                    _count++;
                  });
                },
                child: const Icon(
                  Icons.add,
                  color: Color(0xFF53B175),
                  size: 28,
                ),
              ),
            ],
          ),
          Text(
            "\$${widget.product.price.toStringAsFixed(2)}",
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
        CartService.addToCart(widget.product, count: _count);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Added $_count item${_count > 1 ? 's' : ''} to cart!",
            ),
          ),
        );

        Navigator.pop(context);
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
