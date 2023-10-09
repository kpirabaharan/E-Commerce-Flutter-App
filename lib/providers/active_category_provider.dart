import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/category.dart';

final categoryProvider = NotifierProvider<CategoryNotifier, Category?>(CategoryNotifier.new);

class CategoryNotifier extends Notifier<Category?> {
  @override
  Category? build() {
    return null;
  }

  void setActiveCategory(Category category) {
    state = category;
    ref.notifyListeners();
  }

  void clearActiveCategory() {
    state = null;
    ref.notifyListeners();
  }
}
