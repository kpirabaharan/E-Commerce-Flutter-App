import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveFiltersNotifier extends StateNotifier<Map<String, dynamic>> {
  ActiveFiltersNotifier()
      : super({
          "color": null,
          "size": null,
        });

  void setActiveFilter(String key, dynamic filter) {
    state[key] = filter;
  }

  void clearActiveFilters() {
    state = {'color': null, 'size': null};
  }
}

final activeFiltersProvider = StateNotifierProvider<ActiveFiltersNotifier, Map<String, dynamic>>(
    (ref) => ActiveFiltersNotifier());
