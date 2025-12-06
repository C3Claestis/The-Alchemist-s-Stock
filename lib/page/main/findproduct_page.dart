import 'package:alchemiststock/model/category.dart';
import 'package:alchemiststock/widget/widget_batchProduct.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _header(),
          const Gap(30),
          _searchBar(),
          const Gap(20),
          _content(),
        ],
      ),
    );
  }

  Expanded _content() {
    return Expanded(
      child: SizedBox(
        width: 364,
        child: GridView.builder(
          itemCount: widget.categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // grid 2 kolom
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            final category = widget.categories[index];
            return BatchProduct(
              title: category.name,
              img: "assets/images/batch/${category.name}.png",
              coloring: colors[index % colors.length], // looping warna
            );
          },
        ),
      ),
    );
  }

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
