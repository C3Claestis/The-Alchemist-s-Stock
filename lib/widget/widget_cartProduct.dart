// ignore_for_file: file_names

import 'package:alchemiststock/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CartProduct extends StatefulWidget {
  final ProductModel product;
  final VoidCallback onRemove;
  final ValueChanged<int>? onCountChanged;

  const CartProduct({
    super.key,
    required this.product,
    required this.onRemove,
    this.onCountChanged,
  });

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  late int count; // default
  late double basePrice;

  @override
  void initState() {
    super.initState();
    count = widget.product.count;
    basePrice = widget.product.price; // simpan harga satuan
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 12),
      child: SizedBox(
        width: double.infinity,
        height: 126,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [_img()],
                ),
                const Gap(32),
                _isi(),
              ],
            ),
            Spacer(),
            Divider(height: 1),
          ],
        ),
      ),
    );
  }

  Expanded _isi() {
    return Expanded(
      child: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 40,
              child: _headerNameProduct(),
            ),
            const Gap(6),
            SizedBox(width: double.infinity, height: 60, child: _countItem()),
          ],
        ),
      ),
    );
  }

  SizedBox _img() {
    return SizedBox(
      width: 72,
      height: 72,
      child: Image.asset(
        'assets/images/product/${widget.product.image}.png',
        fit: BoxFit.contain,
      ),
    );
  }

  Row _headerNameProduct() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${widget.product.quantity}${widget.product.unit}, Price',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF7C7C7C),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: widget.onRemove,
            icon: SvgPicture.asset(
              'assets/svgs/cancel.svg',
              height: 16,
              width: 16,
            ),
          ),
        ),
      ],
    );
  }

  Row _countItem() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              if (count > 1) {
                setState(() {
                  count--;
                  widget.product.count = count;
                });
                if (widget.onCountChanged != null) widget.onCountChanged!(count);
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(Icons.remove, size: 22),
            ),
          ),
          const Gap(12),
          Text(
            "$count",
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(12),
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              setState(() {
                count++;
                widget.product.count = count;
              });
              if (widget.onCountChanged != null) widget.onCountChanged!(count);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(Icons.add, size: 22, color: Color(0xFF53B175)),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Text(
          "\$${(count * widget.product.price).toStringAsFixed(2)}", // hitung total
          style: GoogleFonts.roboto(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

}
