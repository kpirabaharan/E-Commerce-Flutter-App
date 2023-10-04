import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:e_commerce/models/product.dart';

final dio = Dio();

class ProductsNotifier extends StateNotifier<List<Product>> {
  ProductsNotifier() : super([]);

  Future<void> fetchProducts(String storeId) async {
    try {
      Response response = await dio.get('${dotenv.env['API_URL']}$storeId/products');
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

  Future<List<Product>> getProducts(String storeId) async {
    await fetchProducts(storeId);
    return state;
  }
}

final productsProvider =
    StateNotifierProvider<ProductsNotifier, List<Product>>((ref) => ProductsNotifier());
