import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeFiltersProvider =
    NotifierProvider<FiltersNotifier, Map<String, dynamic>>(FiltersNotifier.new);

class FiltersNotifier extends Notifier<Map<String, dynamic>> {
  @override
  Map<String, dynamic> build() {
    return {
      'color': null,
      'size': null,
    };
  }

  void setActiveFilter(String filterKey, dynamic category) {
    state[filterKey] = category;
    ref.notifyListeners();
  }

  void clearActiveFilters() {
    state = {
      'color': null,
      'size': null,
    };
    ref.notifyListeners();
  }
}
