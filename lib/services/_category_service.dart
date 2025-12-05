import 'dart:convert';
import 'package:flutter/services.dart'; // Wajib untuk rootBundle
import 'package:alchemiststock/model/category.dart';

class CategoryService {  
  Future<List<CategoryModel>> getCategories() async {
    // Load file JSON dari folder lib/data/
    final String response = 
        await rootBundle.loadString('lib/data/pcategory.json');

    // Decode jadi List
    List data = jsonDecode(response);

    // Mapping ke model CategoryModel
    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
