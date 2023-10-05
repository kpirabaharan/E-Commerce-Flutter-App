import 'package:e_commerce/models/image.dart';
import 'package:e_commerce/models/color.dart';

class Product {
  final String id;
  final String name;
  final int amount;
  final String price;
  final bool isFeatured;
  final List<Image> images;
  final CustomColor color;

  Product({
    required this.id,
    required this.name,
    required this.amount,
    required this.price,
    required this.isFeatured,
    required this.images,
    required this.color,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      price: json['price'],
      isFeatured: json['isFeatured'],
      images: (json['images'] as List<dynamic>).map((image) => Image.fromJson(image)).toList(),
      color: CustomColor.fromJson(json['color']),
    );
  }
}
