import 'package:flyful_farms/config/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiClient()
      : _dio = Dio(BaseOptions(
          baseUrl: Env.apiBaseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        )) {
    _dio.interceptors.add(_AuthInterceptor(_storage));
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Dio get dio => _dio;

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<Map<String, dynamic>> post(String path, {dynamic data}) async {
    final response = await _dio.post(path, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.get(path, queryParameters: queryParameters);
    return response.data;
  }

  Future<Map<String, dynamic>> put(String path, {dynamic data}) async {
    final response = await _dio.put(path, data: data);
    return response.data;
  }

  Future<void> delete(String path) async {
    await _dio.delete(path);
  }
}

class _AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;

  _AuthInterceptor(this._storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.read(key: 'auth_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _storage.delete(key: 'auth_token');
      await _storage.delete(key: 'auth_refresh_token');
    }
    super.onError(err, handler);
  }
}
