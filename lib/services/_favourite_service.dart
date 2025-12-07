// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alchemiststock/model/product.dart';

class FavouriteService {
  static List<ProductModel> _favourites = [];
  static const String _key = 'favourite_items';

  /// Load data favourite dari SharedPreferences
  static Future<void> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString != null) {
      List decoded = jsonDecode(jsonString);
      _favourites = decoded.map((e) => ProductModel.fromJson(e)).toList();
    }
  }

  /// Simpan ke SharedPreferences
  static Future<void> _saveFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    List map = _favourites.map((e) => e.toJson()).toList();
    await prefs.setString(_key, jsonEncode(map));
  }

  static bool isFavourite(ProductModel product) {
    return _favourites.any((p) => p.id == product.id);
  }

  static Future<void> toggleFavourite(ProductModel product) async {
    if (isFavourite(product)) {
      _favourites.removeWhere((p) => p.id == product.id);
    } else {
      _favourites.add(product);
    }

    await _saveFavourites();
  }

  static List<ProductModel> get items => _favourites;
}
