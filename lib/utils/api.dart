import 'package:dio/dio.dart';

class ApiInstance {
  static final Dio _dio = Dio(); // Create a final Dio instance
  // static const baseUrl = 'http://localhost:3000/api/v1/';
  static const baseUrl = 'https://api.sunaguthi.com/api/v1';

  static Future<List<dynamic>> get(url) async {
    try {
      Response response = await _dio.get(
        '$baseUrl$url',
      );
      return response.data['data'];
    } catch (error) {
      return [];
    }
  }

  static Future<List<dynamic>> post(url, fetchdata) async {
    try {
      Response response = await _dio.post(
        '$baseUrl$url',
        data: fetchdata,
      );
      return response.data['data'];
    } catch (error) {
      return [];
    }
  }

  static Future<Map<String, dynamic>> login(url, fetchdata) async {
    print(baseUrl + url);
    print(fetchdata);
    try {
      Response response = await _dio.post(
        '$baseUrl$url',
        data: fetchdata,
      );
      return response.data;
    } catch (error) {
      return {
        'error': error,
      };
    }
  }
}
