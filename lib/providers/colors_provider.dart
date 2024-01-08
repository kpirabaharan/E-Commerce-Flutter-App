import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:e_commerce/models/color.dart';
import 'package:e_commerce/providers/active_store_provider.dart';

final dio = Dio();

final colorsProvider =
    AsyncNotifierProvider.autoDispose<ColorList, List<CustomColor>>(
        ColorList.new);

class ColorList extends AutoDisposeAsyncNotifier<List<CustomColor>> {
  @override
  FutureOr<List<CustomColor>> build() async {
    final store = ref.watch(activeStoreProvider);
    String url = dotenv.env['PROD_API_URL']!;

    Response response = await dio.get(
      '$url${store!.id}/colors',
    );

    return (response.data as List)
        .map((e) => CustomColor.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
