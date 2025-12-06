import 'package:alchemiststock/model/product.dart';

class CartService {
  static List<ProductModel> cartItems = [];

  // Menambahkan item ke cart
  static void addToCart(ProductModel product, {int count = 1}) {
    // Cek apakah produk sudah ada di cart berdasarkan id
    final existingIndex =
        cartItems.indexWhere((item) => item.id == product.id);

    if (existingIndex != -1) {
      // Jika sudah ada, update count
      cartItems[existingIndex].count += count;
    } else {
      // Jika belum ada, tambahkan dengan count tertentu
      final newProduct = ProductModel(
        id: product.id,
        name: product.name,
        category: product.category,
        price: product.price,
        lore: product.lore,
        quantity: product.quantity,
        description: product.description,
        unit: product.unit,
        count: count,
      );
      cartItems.add(newProduct);
    }
  }

  static void removeFromCart(ProductModel product) {
    cartItems.removeWhere((item) => item.id == product.id);
  }

  static List<ProductModel> getCart() {
    return cartItems;
  }

  // Hitung total harga di cart
  static double getTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.count;
    }
    return total;
  }
}
