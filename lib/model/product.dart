class ProductModel {
  final int id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String lore;
  final int quantity;
  final String unit;
  int get image => id;
  int count;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.lore,
    required this.quantity,
    required this.description,
    required this.unit,
    this.count = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      category: json['category'],
      price: double.parse(json['price'].toString()),
      lore: json['lore'],
      quantity: int.parse(json['quantity'].toString()),
      description: json['description'],
      unit: json['unit'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "category": category,
      "price": price,
      "lore": lore,
      "quantity": quantity,
      "unit": unit,
      "count": count,
    };
  }
}
