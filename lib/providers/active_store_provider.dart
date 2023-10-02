import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/store.dart';

class ActiveStoreNotifier extends StateNotifier<Store?> {
  ActiveStoreNotifier() : super(null);

  void setActiveStore(Store store) {
    state = store;
  }

  void clearActiveStore() {
    state = null;
  }
}

final activeStoreProvider =
    StateNotifierProvider<ActiveStoreNotifier, Store?>((ref) => ActiveStoreNotifier());
