import 'package:flyful_farms/features/auth/domain/auth_state.dart';
import 'package:flyful_farms/features/auth/domain/user.dart';

abstract class AuthService {
  Future<User?> login({
    String? email,
    String? phone,
    String? password,
    String? pin,
  });

  Future<User?> register({
    required String phone,
    String? email,
    String? password,
    String? pin,
    String? name,
    String? firstName,
    String? lastName,
    String? village,
    String? county,
  });

  Future<void> logout();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<User?> getCurrentUser();
  Future<AuthStatus> checkAuthStatus();
}
