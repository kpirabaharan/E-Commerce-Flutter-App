import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:e_commerce/models/store.dart';

final dio = Dio();

class StoresNotifier extends StateNotifier<List<Store>> {
  StoresNotifier() : super([]);

  Future<void> fetchStores() async {
    try {
      String url = Platform.isAndroid ? dotenv.env['ANDROID_API_URL']! : dotenv.env['IOS_API_URL']!;
      Response response = await dio.get('${url}users/${dotenv.env['USER_ID']}');
      if (response.statusCode == 200) {
        final List data = response.data;
        state = data.map((e) => Store.fromJson(e)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Store>> getStores() async {
    if (state.isEmpty) {
      await fetchStores();
    }
    return state;
  }
}

final storesProvider =
    StateNotifierProvider<StoresNotifier, List<Store>>((ref) => StoresNotifier());
