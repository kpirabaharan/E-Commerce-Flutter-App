import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:e_commerce/providers/active_store_provider.dart';
import 'package:e_commerce/providers/active_category_provider.dart';

import 'package:e_commerce/models/product.dart';

final dio = Dio();

final productsProvider =
    AsyncNotifierProvider.autoDispose<ProductList, List<Product>>(ProductList.new);

class ProductList extends AutoDisposeAsyncNotifier<List<Product>> {
  @override
  FutureOr<List<Product>> build() async {
    final store = ref.watch(activeStoreProvider);
    final category = ref.watch(categoryProvider);
    final url = Platform.isAndroid ? dotenv.env['ANDROID_API_URL']! : dotenv.env['IOS_API_URL']!;

    String? categoryId;

    if (category != null) {
      categoryId = category.id;
    }

    Map<String, dynamic> queryParameters = {
      'categoryId': categoryId,
    };

    print(queryParameters);

    Response response =
        await dio.get('$url${store!.id}/products', queryParameters: queryParameters);

    return (response.data as List).map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
  }
}
