import 'package:dio/dio.dart';

final dio = Dio();

void fetch(String url, dynamic object ) async{
  try {
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      final List data = response.data;
      object = data.map((e) => object.fromJson(e)).toList();
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception(e);
  }
}