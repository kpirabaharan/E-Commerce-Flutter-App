import 'package:e_commerce/models/image.dart';
import 'package:e_commerce/models/product.dart';

class CartItem {
  final String id;
  final String storeId;
  final String name;
  final String price;
  final CustomImage image;
  final int quantity;

  CartItem({
    required this.id,
    required this.storeId,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  static fromProduct(Product product) {}
}
