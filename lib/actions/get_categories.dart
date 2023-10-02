import 'package:e_commerce/providers/stores_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/providers/categories_provider.dart';

final getCategories = FutureProvider<List<Category>>((ref) async {
  final activeStore = ref.watch(storesProvider).activeStore;
  return ref.watch(categoriesProvider).getCategories(activeStore.id);
});
