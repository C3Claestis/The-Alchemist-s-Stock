// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ExpandType { normal, review, lore }

class CustomExpand extends StatefulWidget {
  final String tittle;
  final String description;
  final ExpandType type;

  const CustomExpand({
    Key? key,
    required this.tittle,
    required this.description,
    required this.type,
  });

  @override
  State<CustomExpand> createState() => _CustomExpandState();
}

class _CustomExpandState extends State<CustomExpand> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HEADER
        GestureDetector(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.tittle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              Spacer(),
              // Jika tipe review → tampilkan rating stars
              if (widget.type == ExpandType.review)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        size: 20,
                        color: Color(0xFFF3603F),
                      ),
                    ),
                  ),
                ),

              //Jika tipe lore
              if (widget.type == ExpandType.lore)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(Icons.auto_stories, size: 18, color: Colors.blueAccent),
                ),

              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_down_sharp
                    : Icons.keyboard_arrow_right_sharp,
                size: 26,
                color: Colors.black,
              ),
            ],
          ),
        ),

        // ANIMATED BODY
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isExpanded ? null : 0,
          padding: isExpanded ? EdgeInsets.only(top: 8) : EdgeInsets.zero,
          child: isExpanded
              ? Text(
                  widget.description,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
