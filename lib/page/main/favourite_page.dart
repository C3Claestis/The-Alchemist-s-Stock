import 'package:alchemiststock/widget/widget_favourite.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _header(),
          const Gap(32),
          Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                FavouriteProduct(),
                FavouriteProduct(),
                FavouriteProduct(),
                FavouriteProduct(),
                FavouriteProduct(),
                FavouriteProduct(),
                ],
              ),
            ),
          ),
          _buttonSubmit(context),
          const Gap(24),
        ],
      ),
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Favourite',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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
        'Add All To Cart',
        style: GoogleFonts.urbanist(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
