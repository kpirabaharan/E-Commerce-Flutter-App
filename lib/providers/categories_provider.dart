import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:e_commerce/models/category.dart';

final dio = Dio();

class CategoriesNotifier extends StateNotifier<List<Category>> {
  CategoriesNotifier() : super([]);

  Future<void> fetchCategories(String storeId) async {
    try {
      String url = Platform.isAndroid ? dotenv.env['ANDROID_API_URL']! : dotenv.env['IOS_API_URL']!;
      Response response = await dio.get('$url$storeId/categories');
      if (response.statusCode == 200) {
        final List data = response.data;
        state = data.map((e) => Category.fromJson(e)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Category>> getCategories(String storeId) async {
    await fetchCategories(storeId);
    return state;
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<Category>>((ref) => CategoriesNotifier());
