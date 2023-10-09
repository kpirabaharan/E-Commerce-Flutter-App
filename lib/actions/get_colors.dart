import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/color.dart';
import 'package:e_commerce/providers/active_store_provider.dart';
import 'package:e_commerce/providers/colors_provider.dart';

final getColors = FutureProvider<List<CustomColor>>((ref) async {
  final activeStore = ref.watch(activeStoreProvider);

  return ref.watch(colorsProvider).fetchColors(activeStore!.id);
});
