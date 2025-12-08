// ignore_for_file: deprecated_member_use

import 'package:alchemiststock/page/Content/ordercomplete_page.dart';
import 'package:alchemiststock/page/RegisterLoginPage/privacyPolicy_page.dart';
import 'package:alchemiststock/page/RegisterLoginPage/termservice_page.dart';
import 'package:alchemiststock/services/_cart_service.dart';
import 'package:alchemiststock/widget/widget_cartProduct.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      onPressed: () {
        _checkout(context);
      },
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

  Future<dynamic> _checkout(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return ListView(
              controller: scrollController,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Checkout",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/svgs/cancel.svg',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                Divider(height: 1, indent: 0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  height: 56,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Color(0xFF7C7C7C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Select Method",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Color(0xFF181725),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Gap(15),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Divider(height: 1),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  height: 56,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Payment",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Color(0xFF7C7C7C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset('assets/svgs/paycard.svg'),
                                  const Gap(15),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Divider(height: 1),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  height: 56,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Promo Code",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Color(0xFF7C7C7C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Pick Discount",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Color(0xFF181725),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Gap(15),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Divider(height: 1),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  height: 56,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Cost",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Color(0xFF7C7C7C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${_calculateTotalPrice().toStringAsFixed(2)}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Color(0xFF181725),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Gap(15),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Divider(height: 1),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 25),
                  child: _termPolicyTxt(context),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: _btnCheckout(context),
                ),
              ],
            );
          },
        );
      },
    );
  }

  RichText _termPolicyTxt(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "By placing an order you agree to our ",
        style: GoogleFonts.poppins(
          color: Colors.grey.shade700,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: "\nTerms ",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TermservicePage()),
                ); // aksi klik
              },
          ),
          TextSpan(
            text: "And",
            style: GoogleFonts.poppins(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: " Conditions",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacypolicyPage()),
                ); // aksi klik
              },
          ),
        ],
      ),
    );
  }

  ElevatedButton _btnCheckout(BuildContext context) {
    return ElevatedButton(
      onPressed: () {        
        CartService.clearCart();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const OrdercompletePage()),
          (Route<dynamic> route) => false, // Hapus semua route
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF53B175),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        minimumSize: const Size(353, 67),
      ),
      child: Text(
        'Place Order',
        style: GoogleFonts.urbanist(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
