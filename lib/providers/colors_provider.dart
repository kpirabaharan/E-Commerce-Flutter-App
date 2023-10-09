import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:e_commerce/models/color.dart';

final dio = Dio();

class ColorsProvider {
  Future<List<CustomColor>> fetchColors(String storeId) async {
    try {
      String url = Platform.isAndroid ? dotenv.env['ANDROID_API_URL']! : dotenv.env['IOS_API_URL']!;
      Response response = await dio.get('$url$storeId/colors');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) => CustomColor.fromJson(e)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

final colorsProvider = Provider<ColorsProvider>((ref) => ColorsProvider());
