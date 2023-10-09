import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/color.dart';
import 'package:e_commerce/models/size.dart';

class ActiveFiltersNotifier extends StateNotifier<Map<String, dynamic>> {
  ActiveFiltersNotifier()
      : super({
          "color": null,
          "size": null,
        });

  void setActiveColor(dynamic color) {
    state['color'] = color;
  }

  void setActiveSize(dynamic size) {
    state['size'] = size;
  }

  void clearActiveFilters() {
    state = {'color': null, 'size': null};
  }
}

final activeFiltersProvider = StateNotifierProvider<ActiveFiltersNotifier, Map<String, dynamic>>(
    (ref) => ActiveFiltersNotifier());
