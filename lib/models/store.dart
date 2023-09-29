import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/models/size.dart';

class Store {
  final String id;
  final String name;
  final int limit;
  final String color;
  final List<Category> categories;
  final List<Size> sizes;

  const Store({
    required this.id,
    required this.name,
    required this.limit,
    required this.color,
    required this.categories,
    required this.sizes,
  });
}
