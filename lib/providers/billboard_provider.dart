import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:e_commerce/models/billboard.dart';

final dio = Dio();

class BillboardNotifier extends StateNotifier<Billboard?> {
  BillboardNotifier() : super(null);

  Future<void> fetchBillboard(String storeId, String billboardId) async {
    try {
      String url = Platform.isAndroid ? dotenv.env['ANDROID_API_URL']! : dotenv.env['IOS_API_URL']!;
      Response response = await dio.get('$url$storeId/billboards/$billboardId');
      if (response.statusCode == 200) {
        final data = response.data;
        state = Billboard.fromJson(data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Billboard> getBillboard(String storeId, String billboardId) async {
    await fetchBillboard(storeId, billboardId);
    return state as Billboard;
  }
}

final billboardProvider =
    StateNotifierProvider<BillboardNotifier, Billboard?>((ref) => BillboardNotifier());
