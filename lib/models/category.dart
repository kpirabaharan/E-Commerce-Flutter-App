import 'package:e_commerce/models/store.dart';

class Category {
  final String id;
  final String storeId;
  final String billboardId;
  final String name;
  final Store store;

  const Category({
    required this.id,
    required this.storeId,
    required this.billboardId,
    required this.name,
    required this.store,
  });
}
