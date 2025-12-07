// ignore_for_file: prefer_final_fields

import 'package:alchemiststock/model/product.dart';

class FavouriteService {
  static List<ProductModel> _favourites = [];

  static bool isFavourite(ProductModel product) {
    return _favourites.any((p) => p.id == product.id);
  }

  static void toggleFavourite(ProductModel product) {
    if (isFavourite(product)) {
      _favourites.removeWhere((p) => p.id == product.id);
    } else {
      _favourites.add(product);
    }
  }

  static List<ProductModel> get items => _favourites;
}
