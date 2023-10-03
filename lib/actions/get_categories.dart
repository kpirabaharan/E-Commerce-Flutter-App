import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/providers/categories_provider.dart';
import 'package:e_commerce/providers/active_store_provider.dart';

final getCategories = FutureProvider<List<Category>>((ref) async {
  final activeStore = ref.watch(activeStoreProvider);
  return ref.watch(categoriesProvider.notifier).getCategories(activeStore!.id);
});
