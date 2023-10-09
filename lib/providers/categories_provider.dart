import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/providers/active_store_provider.dart';

final dio = Dio();

final categoriesProvider =
    AsyncNotifierProvider.autoDispose<CategoryList, List<Category>>(CategoryList.new);

class CategoryList extends AutoDisposeAsyncNotifier<List<Category>> {
  @override
  FutureOr<List<Category>> build() async {
    final store = ref.watch(activeStoreProvider);
    final url = Platform.isAndroid ? dotenv.env['ANDROID_API_URL']! : dotenv.env['IOS_API_URL']!;

    Response response = await dio.get(
      '$url${store!.id}/categories',
    );

    return (response.data as List)
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
