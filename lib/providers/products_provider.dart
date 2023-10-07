import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:e_commerce/models/product.dart';

final dio = Dio();

class ProductsNotifier extends StateNotifier<List<Product>> {
  ProductsNotifier() : super([]);

  Future<void> fetchProducts(String storeId,
      {String? categoryId, String? sizeId, String? colorId, bool? isFeatured}) async {
    try {
      Map<String, dynamic> queryParameters = {
        'categoryId': categoryId,
        'sizeId': sizeId,
        'colorId': colorId,
        'isFeatured': isFeatured
      };
      String url = Platform.isAndroid ? dotenv.env['ANDROID_API_URL']! : dotenv.env['IOS_API_URL']!;
      Response response = await dio.get('$url$storeId/products', queryParameters: queryParameters);

      if (response.statusCode == 200) {
        final List data = response.data;
        state = data.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Product>> getProducts(String storeId,
      {String? categoryId, String? sizeId, String? colorId, bool? isFeatured}) async {
    await fetchProducts(storeId,
        categoryId: categoryId, sizeId: sizeId, colorId: colorId, isFeatured: isFeatured);
    return state;
  }

  Product getProduct(String productId) {
    return state.firstWhere((element) => element.id == productId);
  }
}

final productsProvider =
    StateNotifierProvider<ProductsNotifier, List<Product>>((ref) => ProductsNotifier());
