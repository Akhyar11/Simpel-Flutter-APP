// lib/models/product_model.dart
class Product {
  final int id;
  final String name;
  final String color;
  final int year;
  final String pantoneValue;

  Product({
    required this.id,
    required this.name,
    required this.color,
    required this.year,
    required this.pantoneValue,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      year: json['year'],
      pantoneValue: json['pantone_value'],
    );
  }
}
