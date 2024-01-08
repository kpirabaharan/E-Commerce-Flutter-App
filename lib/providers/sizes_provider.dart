import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:e_commerce/models/size.dart';
import 'package:e_commerce/providers/active_store_provider.dart';

final dio = Dio();

final sizesProvider =
    AsyncNotifierProvider.autoDispose<SizeList, List<Size>>(SizeList.new);

class SizeList extends AutoDisposeAsyncNotifier<List<Size>> {
  @override
  FutureOr<List<Size>> build() async {
    final store = ref.watch(activeStoreProvider);
    String url = dotenv.env['PROD_API_URL']!;

    Response response = await dio.get(
      '$url${store!.id}/sizes',
    );

    return (response.data as List)
        .map((e) => Size.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
