import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:e_commerce/models/store.dart';

final dio = Dio();

final storesProvider = AsyncNotifierProvider.autoDispose<StoreList, List<Store>>(StoreList.new);

class StoreList extends AutoDisposeAsyncNotifier<List<Store>> {
  @override
  FutureOr<List<Store>> build() async {
    final url = Platform.isAndroid ? dotenv.env['ANDROID_API_URL']! : dotenv.env['IOS_API_URL']!;

    Response response = await dio.get(
      '${url}users/${dotenv.env['USER_ID']}',
    );

    return (response.data as List).map((e) => Store.fromJson(e as Map<String, dynamic>)).toList();
  }
}
