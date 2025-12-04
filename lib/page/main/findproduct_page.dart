import 'package:alchemiststock/widget/widget_batchProduct.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FindproductPage extends StatefulWidget {
  const FindproductPage({super.key});

  @override
  State<FindproductPage> createState() => _FindproductPageState();
}

class _FindproductPageState extends State<FindproductPage> {
  final List<Map<String, dynamic>> products = [
    {"title": "Peti", "img": "assets/images/product/peti.png", "color": Colors.blue},
    {"title": "Kue", "img": "assets/images/product/Kue.png", "color": Colors.green},
    {"title": "Potion", "img": "assets/images/product/Potion.png", "color": Colors.brown},
    {"title": "Santet", "img": "assets/images/product/Santet.png", "color": Colors.yellow.shade400},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
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
          ),
          const Gap(30),
          _searchBar(),
          const Gap(20),
          Expanded(
            child: SizedBox(
              width: 364,            
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // grid 2 kolom
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,                  
                ),
                itemBuilder: (context, index) {
                  return BatchProduct(
                    title: products[index]["title"],
                    img: products[index]["img"],
                    coloring: products[index]["color"],
                  );
                },
              ),
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
}
