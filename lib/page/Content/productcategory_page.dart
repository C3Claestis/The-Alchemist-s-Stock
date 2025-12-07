// ignore_for_file: deprecated_member_use

import 'package:alchemiststock/model/category.dart';
import 'package:alchemiststock/model/product.dart';
import 'package:alchemiststock/services/_product_service.dart';
import 'package:alchemiststock/widget/widget_product_sell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductcategoryPage extends StatefulWidget {
  final CategoryModel category;

  const ProductcategoryPage({super.key, required this.category});

  @override
  State<ProductcategoryPage> createState() => _ProductcategoryPageState();
}

class _ProductcategoryPageState extends State<ProductcategoryPage> {
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService().getProducts(); // ← ambil data API di sini
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            FutureBuilder<List<ProductModel>>(
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
                return Expanded(
                  child: _contentCard(products),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentCard(List<ProductModel> products) {
    // Filter produk berdasarkan kategori yang dipilih
    final displayedProducts = products
        .where((product) => product.category == widget.category.name)
        .toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.7,
        ),
        itemCount: displayedProducts.length,
        itemBuilder: (context, index) {
          return ProductSell(product: displayedProducts[index]);
        },
      ),
    );
  }

  Padding _header() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          ),
          Text(
            widget.category.name,
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              
            },
            icon: SvgPicture.asset(
              'assets/svgs/filter.svg',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
