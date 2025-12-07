import 'package:alchemiststock/services/_favourite_service.dart';
import 'package:alchemiststock/widget/widget_favourite.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await FavouriteService.loadFavourites();
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    final favouriteItems = FavouriteService.items;

    return SafeArea(
      child: Column(
        children: [
          _header(),
          const Gap(32),
          Divider(height: 1),
          Expanded(
            child: favouriteItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Chixia_sticker.png',
                          width: 150,
                          height: 150,
                        ),
                        Text(
                          "You have no favourite items",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: favouriteItems.length,
                    itemBuilder: (context, index) =>
                        FavouriteProduct(product: favouriteItems[index]),
                  ),
          ),
          if (favouriteItems.isNotEmpty) _buttonSubmit(context),
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
