import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:e_commerce/models/store.dart';

final dio = Dio();

class StoresProvider {
  late Store activeStore;

  Future<List<Store>> getStores() async {
    try {
      Response response = await dio.get('${dotenv.env['API_URL']}users/${dotenv.env['USER_ID']}');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) => Store.fromJson(e)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void setActiveStore(Store store) {
    activeStore = store;
  }
}

final storesProvider = Provider<StoresProvider>((ref) => StoresProvider());
