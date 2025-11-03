import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio;
  final SharedPreferences _prefs;

  ApiService(this._dio, this._prefs) {
    _dio.options.baseUrl =
        'https://codingarabic.online/api'; // Replace with actual base URL
    _dio.options.headers = {'Content-Type': 'application/json'};
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _prefs.getString('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }

  Future<Response> patch(String path, {dynamic data}) {
    return _dio.patch(path, data: data);
  }

  Future<Response> delete(String path) {
    return _dio.delete(path);
  }
}
