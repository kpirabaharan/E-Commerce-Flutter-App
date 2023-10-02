import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:e_commerce/models/category.dart';

final dio = Dio();

class CategoriesProvider {
  Future<List<Category>> getCategories(String storeId) async {
    try {
      Response response = await dio.get('${dotenv.env['API_URL']}$storeId/categories');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) => Category.fromJson(e)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

final categoriesProvider = Provider<CategoriesProvider>((ref) => CategoriesProvider());
