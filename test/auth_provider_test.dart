import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/features/auth/domain/auth_service.dart';
import 'package:flyful_farms/features/auth/domain/auth_state.dart';
import 'package:flyful_farms/features/auth/domain/user.dart';
import 'package:flyful_farms/features/auth/presentation/providers/auth_provider.dart';

class _FakeAuthService implements AuthService {
  User? loginResult;
  Object? loginError;
  User? registerResult;
  Object? registerError;
  AuthStatus authStatusResult = AuthStatus.unauthenticated;
  Object? checkStatusError;
  User? currentUser;

  @override
  Future<User?> login({
    String? email,
    String? phone,
    String? password,
    String? pin,
  }) async {
    if (loginError != null) throw loginError!;
    return loginResult;
  }

  @override
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
  }) async {
    if (registerError != null) throw registerError!;
    return registerResult;
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> saveToken(String token) async {}

  @override
  Future<String?> getToken() async => null;

  @override
  Future<void> clearToken() async {}

  @override
  Future<User?> getCurrentUser() async => currentUser;

  @override
  Future<AuthStatus> checkAuthStatus() async {
    if (checkStatusError != null) throw checkStatusError!;
    return authStatusResult;
  }
}

void main() {
  late _FakeAuthService service;
  late AuthProvider provider;

  setUp(() {
    service = _FakeAuthService();
    provider = AuthProvider(service);
  });

  const user = User(id: 1, email: 'a@b.com', firstName: 'Jane');

  group('login', () {
    test('authenticates and stores user when login succeeds', () async {
      service.loginResult = user;

      final ok = await provider.login(email: 'a@b.com', password: 'pw');

      expect(ok, isTrue);
      expect(provider.status, AuthStatus.authenticated);
      expect(provider.user, user);
      expect(provider.errorMessage, isNull);
    });

    test('reports error when service returns null user', () async {
      service.loginResult = null;

      final ok = await provider.login(email: 'a@b.com', password: 'pw');

      expect(ok, isFalse);
      expect(provider.status, AuthStatus.error);
      expect(provider.errorMessage, 'Invalid credentials');
    });

    test('handles thrown exceptions gracefully', () async {
      service.loginError = Exception('boom');

      final ok = await provider.login(email: 'a@b.com', password: 'pw');

      expect(ok, isFalse);
      expect(provider.status, AuthStatus.error);
      expect(provider.errorMessage, 'An error occurred. Please try again.');
    });
  });

  group('register', () {
    test('authenticates and stores user on success', () async {
      service.registerResult = user;

      final ok = await provider.register(phone: '0712345678');

      expect(ok, isTrue);
      expect(provider.status, AuthStatus.authenticated);
      expect(provider.user, user);
    });

    test('reports failure when register returns null', () async {
      service.registerResult = null;

      final ok = await provider.register(phone: '0712345678');

      expect(ok, isFalse);
      expect(provider.errorMessage, 'Registration failed');
    });
  });

  group('checkAuthStatus', () {
    test('loads user when authenticated', () async {
      service.authStatusResult = AuthStatus.authenticated;
      service.currentUser = user;

      await provider.checkAuthStatus();

      expect(provider.status, AuthStatus.authenticated);
      expect(provider.user, user);
    });

    test('clears user when unauthenticated', () async {
      service.authStatusResult = AuthStatus.unauthenticated;

      await provider.checkAuthStatus();

      expect(provider.status, AuthStatus.unauthenticated);
      expect(provider.user, isNull);
    });

    test('falls back to unauthenticated on exception', () async {
      service.checkStatusError = Exception('db locked');

      await provider.checkAuthStatus();

      expect(provider.status, AuthStatus.unauthenticated);
      expect(provider.user, isNull);
    });
  });

  group('logout', () {
    test('clears user and status', () async {
      service.loginResult = user;
      await provider.login(email: 'a@b.com', password: 'pw');
      expect(provider.status, AuthStatus.authenticated);

      await provider.logout();

      expect(provider.status, AuthStatus.unauthenticated);
      expect(provider.user, isNull);
    });
  });

  group('notifications', () {
    test('notifies listeners on state changes', () async {
      var notified = 0;
      provider.addListener(() => notified++);

      service.loginResult = user;
      await provider.login(email: 'a@b.com', password: 'pw');

      expect(notified, greaterThan(0));
    });
  });
}
