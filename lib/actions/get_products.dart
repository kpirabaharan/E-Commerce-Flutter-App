import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/active_store_provider.dart';
import 'package:e_commerce/providers/category_provider.dart';
import 'package:e_commerce/providers/active_fliters_provider.dart';
import 'package:e_commerce/providers/products_provider.dart';

final getProducts = FutureProvider<List<Product>>((ref) async {
  final activeStore = ref.watch(activeStoreProvider);
  final activeCategory = ref.watch(categoryProvider);
  final activeFilters = ref.watch(activeFiltersProvider);

  print(activeCategory?.id);
  print(activeFilters['size'].id);

  return ref.watch(productsProvider.notifier).getProducts(
        activeStore!.id,
        categoryId: activeCategory?.id,
        sizeId: activeFilters['size'].id,
        colorId: activeFilters['color'].id,
      );
});
