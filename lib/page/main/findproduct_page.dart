import 'package:alchemiststock/model/category.dart';
import 'package:alchemiststock/model/product.dart';
import 'package:alchemiststock/page/Content/productcategory_page.dart';
import 'package:alchemiststock/services/_product_service.dart';
import 'package:alchemiststock/widget/widget_batchProduct.dart';
import 'package:alchemiststock/widget/widget_product_sell.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FindproductPage extends StatefulWidget {
  final List<CategoryModel> categories;

  const FindproductPage({super.key, required this.categories});

  @override
  State<FindproductPage> createState() => _FindproductPageState();
}

class _FindproductPageState extends State<FindproductPage> {
  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.brown,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.red,
    Colors.cyan,
  ];

  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];

  String query = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final products = await ProductService().getProducts();
      setState(() {
        allProducts = products;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _header(),
          const Gap(30),
          _searchBar(),
          const Gap(20),
          isLoading ? _loading() : _content(),
        ],
      ),
    );
  }

  // ------------------------
  //      SEARCH BAR
  // ------------------------
  Container _searchBar() {
    return Container(
      width: 364,
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;

                  filteredProducts = allProducts
                      .where((p) => p.name.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: const InputDecoration(
                hintText: "Search item...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------
  //       MAIN CONTENT
  // ------------------------
  Expanded _content() {
    // ➤ Tidak sedang search → tampil kategori
    if (query.isEmpty) {
      return Expanded(
        child: SizedBox(
          width: 364,
          child: GridView.builder(
            itemCount: widget.categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              final category = widget.categories[index];
              return BatchProduct(
                title: category.name,
                img: "assets/images/batch/${category.name}.png",
                coloring: colors[index % colors.length],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductcategoryPage(category: category),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    }

    // ➤ Sedang search → tampilkan produk
    return Expanded(
      child: SizedBox(
        width: 364,
        child: GridView.builder(
          itemCount: filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return ProductSell(product: filteredProducts[index]);
          },
        ),
      ),
    );
  }

  // ------------------------
  //      HEADER
  // ------------------------
  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Find Products',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ------------------------
  //     LOADING SCREEN
  // ------------------------
  Widget _loading() {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
