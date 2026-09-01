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
  final Dio _refreshDio;
  bool _isRefreshing = false;
  String? _pendingToken;

  static const _tokenKey = 'auth_token';
  static const _refreshTokenKey = 'auth_refresh_token';

  _AuthInterceptor(this._storage)
      : _refreshDio = Dio(BaseOptions(
          baseUrl: Env.apiBaseUrl,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.read(key: _tokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final sentAuthHeader =
        err.requestOptions.headers['Authorization']?.toString() ?? '';
    final isAuthenticatedRequest = sentAuthHeader.startsWith('Bearer ');
    final is401 = err.response?.statusCode == 401;

    if (is401 && isAuthenticatedRequest) {
      final refreshed = await _tryRefresh();
      if (refreshed && err.requestOptions.path != '/auth/refresh') {
        final newToken = await _storage.read(key: _tokenKey);
        if (newToken != null) {
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          try {
            final clone = await _refreshDio.fetch(
              err.requestOptions.copyWith(headers: {
                ...err.requestOptions.headers,
                'Authorization': 'Bearer $newToken',
              }),
            );
            return handler.resolve(clone);
          } catch (_) {}
        }
      }
    }

    if (is401 && isAuthenticatedRequest && !err.requestOptions.path.startsWith('/auth')) {
      await _storage.delete(key: _tokenKey);
      await _storage.delete(key: _refreshTokenKey);
    }

    super.onError(err, handler);
  }

  Future<bool> _tryRefresh() async {
    if (_isRefreshing) {
      // Wait for the in-flight refresh to complete and reuse its token.
      for (var i = 0; i < 50 && _pendingToken == null; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 100));
      }
      return _pendingToken != null;
    }

    final refreshToken = await _storage.read(key: _refreshTokenKey);
    if (refreshToken == null || refreshToken.isEmpty) return false;

    _isRefreshing = true;
    try {
      final response = await _refreshDio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      final data = response.data as Map<String, dynamic>;
      final newToken = data['token']?.toString();
      if (newToken != null && newToken.isNotEmpty) {
        await _storage.write(key: _tokenKey, value: newToken);
        _pendingToken = newToken;
        return true;
      }
      return false;
    } catch (_) {
      return false;
    } finally {
      _isRefreshing = false;
    }
  }
}
