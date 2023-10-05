import 'package:e_commerce/providers/category_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/products_provider.dart';
import 'package:e_commerce/providers/active_store_provider.dart';

final getProducts = FutureProvider<List<Product>>((ref) async {
  final activeStore = ref.watch(activeStoreProvider);
  final activeCategory = ref.watch(categoryProvider);

  return ref
      .watch(productsProvider.notifier)
      .getProducts(activeStore!.id, categoryId: activeCategory?.id);
});
