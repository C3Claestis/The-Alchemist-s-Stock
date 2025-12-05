import 'package:alchemiststock/model/product.dart';
import 'package:alchemiststock/services/_product_service.dart';
import 'package:alchemiststock/widget/widget_product_rare.dart';
import 'package:alchemiststock/widget/widget_product_sell.dart';
import 'package:alchemiststock/widget/widget_promo_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomescreenPage extends StatefulWidget {
  const HomescreenPage({super.key});

  @override
  State<HomescreenPage> createState() => _HomescreenPageState();
}

class _HomescreenPageState extends State<HomescreenPage> {
  late Future<List<Product>> futureProducts;

  String zone = 'Jawa Barat';
  String area = 'Bogor';

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService().getProducts();  // ← ambil data API di sini
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(          
          children: [
            _logoIcon(),
            const Gap(8),
            _locationHeader(),
            const Gap(18),
            _searchBar(),
            const Gap(20),
            PromoBanner(),
            const Gap(30),
            FutureBuilder<List<Product>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 100),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final products = snapshot.data ?? [];

                // Pindahkan semua widget yang butuh data 'products' ke sini
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _contentTitleTxt("Exclusive Offer"),
                    const Gap(20),
                    _contentCard(products, start: 0, end: 5),
                    const Gap(30),
                    _contentTitleTxt("Best Selling"),
                    const Gap(20),
                    _contentCard(products, start: 5, end: 10),
                    const Gap(30),
                    _contentTitleTxt("Groceries"),
                    const Gap(20),
                    _contentCardRare(),
                    const Gap(20),
                    _contentCard(products, start: 10, end: 15),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding _contentCardRare() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: SizedBox(
        height: 105,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => ProductRare(),
          separatorBuilder: (context, index) => const Gap(14),
          itemCount: 3,
        ),
      ),
    );
  }

  Padding _contentCard(List<Product> products, {int start = 0, int? end}) {
    // Ambil sublist dari produk berdasarkan rentang start dan end
    // Pastikan rentang tidak melebihi panjang list
    final int effectiveEnd = (end != null && end <= products.length) ? end : products.length;
    final displayedProducts = products.sublist(start, effectiveEnd);

    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: SizedBox(
        height: 248,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            // Ambil produk dari list yang sudah difilter
            final product = displayedProducts[index];
            return ProductSell(product: product);
          },
          separatorBuilder: (context, index) => const Gap(14),
          itemCount: displayedProducts.length, // Sesuaikan jumlah item
        ),
      ),
    );
  }

  Padding _contentTitleTxt(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'See all',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Color(0xFF53B175),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Container _searchBar() {
    return Container(
      width: 364,
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF2F3F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0)),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search item...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _locationHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/svgs/pointermap.svg'),
        const Gap(8),
        Text(
          '$zone, $area',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Padding _logoIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Witch_Hat.png', color: Colors.brown),
        ],
      ),
    );
  }
}
