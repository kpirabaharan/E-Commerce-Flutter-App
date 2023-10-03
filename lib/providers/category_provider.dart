import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/category.dart';

class CategoryNotifier extends StateNotifier<Category?> {
  CategoryNotifier() : super(null);

  void setActiveStore(Category category) {
    state = category;
  }

  void clearActiveStore() {
    state = null;
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, Category?>((ref) => CategoryNotifier());
