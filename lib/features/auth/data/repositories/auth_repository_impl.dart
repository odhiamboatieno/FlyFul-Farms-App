import 'package:flyful_farms/config/di.dart';
import 'package:flyful_farms/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flyful_farms/features/auth/data/models/user_model.dart';
import 'package:flyful_farms/features/auth/domain/auth_service.dart';
import 'package:flyful_farms/features/auth/domain/auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl implements AuthService {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl(this.remoteDataSource, this.secureStorage);

  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'auth_refresh_token';
  static const String _userIdKey = 'auth_user_id';

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
      return UserModel.fromJson(userJson);
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
      return UserModel.fromJson(userJson);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
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
    apiClient.clearToken();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final token = await getToken();
    if (token == null) return null;
    apiClient.setToken(token);
    try {
      return await remoteDataSource.getCurrentUser();
    } catch (e) {
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
      return await remoteDataSource.updateProfile(data);
    } catch (e) {
      return null;
    }
  }
}
