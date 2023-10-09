import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/size.dart';
import 'package:e_commerce/providers/active_store_provider.dart';
import 'package:e_commerce/providers/sizes_provider.dart';

final getSizes = FutureProvider<List<Size>>((ref) async {
  final activeStore = ref.watch(activeStoreProvider);

  return ref.watch(sizesProvider).fetchSizes(activeStore!.id);
});
