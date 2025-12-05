import 'dart:convert';
import 'package:alchemiststock/model/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


class ProductService {
  static final String baseUrl = dotenv.env['API_PRODUCT_URL'] ?? 'fallback_url';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load product");
    }
  }
}
