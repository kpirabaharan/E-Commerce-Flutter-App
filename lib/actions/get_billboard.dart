import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/billboard.dart';
import 'package:e_commerce/providers/billboard_provider.dart';
import 'package:e_commerce/providers/active_store_provider.dart';
import 'package:e_commerce/providers/active_category_provider.dart';

final getBillboard = FutureProvider<Billboard>((ref) async {
  final activeStore = ref.watch(activeStoreProvider);
  final activeCategory = ref.watch(activeCategoryProvider);

  final billboardId = activeCategory?.billboardId ?? activeStore!.homeBillboardId;

  return ref.watch(billboardProvider.notifier).getBillboard(activeStore!.id, billboardId);
});
