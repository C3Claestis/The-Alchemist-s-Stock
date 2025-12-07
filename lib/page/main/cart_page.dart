import 'package:alchemiststock/services/_cart_service.dart';
import 'package:alchemiststock/widget/widget_cartProduct.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cart = CartService.getCart();

  double _calculateTotalPrice() {
    return cart.fold(0.0, (sum, item) => sum + (item.price * item.count));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _header(),
          const Gap(32),
          Divider(height: 1),
          Expanded(
            child: cart.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Rover_sticker.png', 
                          width: 150,
                          height: 150,
                        ),                        
                        Text(
                          "Your cart is empty",
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
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      return CartProduct(
                        product: cart[index],
                        onRemove: () {
                          setState(() {
                            CartService.removeFromCart(cart[index]);
                          });
                        },
                        onCountChanged: (newCount) {
                          setState(() {}); // update total price
                        },
                      );
                    },
                  ),
          ),
          if (cart.isNotEmpty)
            _buttonSubmit(context), // hanya tampil jika ada item
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
          'My Cart',
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
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF53B175),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        minimumSize: const Size(353, 67),
        padding: EdgeInsets.zero,
      ),
      child: SizedBox(
        width: 353,
        height: 67,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ❇ Teks di tengah
            Text(
              'Go to Checkout',
              style: GoogleFonts.urbanist(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            // ❇ Harga di kanan dengan padding
            Positioned(
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '\$${_calculateTotalPrice().toStringAsFixed(2)}',
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
