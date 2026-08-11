import 'dart:convert';

import 'package:flyful_farms/config/di.dart';
import 'package:flyful_farms/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flyful_farms/features/auth/data/models/user_model.dart';
import 'package:flyful_farms/features/auth/domain/auth_service.dart';
import 'package:flyful_farms/features/auth/domain/auth_state.dart';
import 'package:flyful_farms/features/auth/domain/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl implements AuthService {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl(this.remoteDataSource, this.secureStorage);

  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'auth_refresh_token';
  static const String _userIdKey = 'auth_user_id';
  static const String _userJsonKey = 'auth_user_json';

  @override
  Future<UserModel?> login({
    String? email,
    String? phone,
    String? password,
    String? pin,
  }) async {
    final data = <String, dynamic>{};
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (password != null) data['password'] = password;
    if (pin != null) data['pin'] = pin;

    final response = await remoteDataSource.login(data);

    final token = response['token'] as String?;
    final refreshToken = response['refreshToken'] as String?;
    final userJson = response['user'] as Map<String, dynamic>?;

    if (token != null && userJson != null) {
      await saveToken(token);
      if (refreshToken != null) {
        await secureStorage.write(key: _refreshTokenKey, value: refreshToken);
      }
      apiClient.setToken(token);
      final user = UserModel.fromJson(userJson);
      await _cacheUser(user);
      return user;
    }
    return null;
  }

  @override
  Future<UserModel?> register({
    required String phone,
    String? email,
    String? password,
    String? pin,
    String? name,
    String? firstName,
    String? lastName,
    String? village,
    String? county,
  }) async {
    final data = <String, dynamic>{
      'phone': phone,
    };
    if (email != null) data['email'] = email;
    if (password != null) data['password'] = password;
    if (pin != null) data['pin'] = pin;
    if (name != null) data['name'] = name;
    if (firstName != null) data['firstName'] = firstName;
    if (lastName != null) data['lastName'] = lastName;
    if (village != null) data['village'] = village;
    if (county != null) data['county'] = county;

    final response = await remoteDataSource.register(data);

    final token = response['token'] as String?;
    final refreshToken = response['refreshToken'] as String?;
    final userJson = response['user'] as Map<String, dynamic>?;

    if (token != null && userJson != null) {
      await saveToken(token);
      if (refreshToken != null) {
        await secureStorage.write(key: _refreshTokenKey, value: refreshToken);
      }
      apiClient.setToken(token);
      final user = UserModel.fromJson(userJson);
      await _cacheUser(user);
      return user;
    }
    return null;
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } catch (_) {
      // Offline-first: a failed remote call must not block signing out.
      // The local token is cleared below; the server token expires on its own.
    }
    await clearToken();
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: _tokenKey);
  }

  @override
  Future<void> clearToken() async {
    await secureStorage.delete(key: _tokenKey);
    await secureStorage.delete(key: _refreshTokenKey);
    await secureStorage.delete(key: _userIdKey);
    await secureStorage.delete(key: _userJsonKey);
    apiClient.clearToken();
  }

  Future<void> _cacheUser(User user) async {
    await secureStorage.write(key: _userJsonKey, value: jsonEncode(user.toJson()));
  }

  Future<User?> _cachedUser() async {
    final raw = await secureStorage.read(key: _userJsonKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return User.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final token = await getToken();
    if (token == null) return null;
    apiClient.setToken(token);
    try {
      final user = await remoteDataSource.getCurrentUser();
      await _cacheUser(user);
      return user;
    } catch (e) {
      final cached = await _cachedUser();
      if (cached != null) {
        return UserModel(
          id: cached.id,
          email: cached.email,
          phone: cached.phone,
          firstName: cached.firstName,
          lastName: cached.lastName,
          role: cached.role,
          village: cached.village,
          county: cached.county,
          avatar: cached.avatar,
          isActive: cached.isActive,
          createdAt: cached.createdAt,
          updatedAt: cached.updatedAt,
        );
      }
      return null;
    }
  }

  @override
  Future<AuthStatus> checkAuthStatus() async {
    final token = await getToken();
    if (token == null) return AuthStatus.unauthenticated;
    final user = await getCurrentUser();
    return user != null
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
  }

  @override
  Future<bool> forgotPassword(String phone) async {
    await remoteDataSource.forgotPassword({'phone': phone});
    return true;
  }

  @override
  Future<UserModel?> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? village,
    String? county,
  }) async {
    final token = await getToken();
    if (token == null) return null;
    apiClient.setToken(token);

    final data = <String, dynamic>{};
    if (firstName != null) data['firstName'] = firstName;
    if (lastName != null) data['lastName'] = lastName;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (village != null) data['village'] = village;
    if (county != null) data['county'] = county;

    if (data.isEmpty) return await getCurrentUser();

    try {
      final user = await remoteDataSource.updateProfile(data);
      await _cacheUser(user);
      return user;
    } catch (e) {
      return await getCurrentUser();
    }
  }
}
