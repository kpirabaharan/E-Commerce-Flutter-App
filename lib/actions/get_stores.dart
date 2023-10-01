import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/store.dart';
import 'package:e_commerce/providers/stores_provider.dart';

final getStores = FutureProvider<List<Store>>((ref) async {
  return ref.watch(storesProvider).getStores();
});
