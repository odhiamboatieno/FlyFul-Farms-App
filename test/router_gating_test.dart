import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/app/app.dart';
import 'package:flyful_farms/config/di.dart';
import 'package:flyful_farms/features/auth/domain/auth_service.dart';
import 'package:flyful_farms/features/auth/domain/auth_state.dart';
import 'package:flyful_farms/features/auth/domain/user.dart';
import 'package:flyful_farms/features/auth/presentation/providers/auth_provider.dart';
import 'package:flyful_farms/features/auth/presentation/pages/login_page.dart';
import 'package:flyful_farms/features/dashboard/presentation/pages/today_page.dart';

class _FakeAuthService implements AuthService {
  _FakeAuthService(this.status, this.currentUser);

  final AuthStatus status;
  final User? currentUser;

  @override
  Future<User?> login({String? email, String? phone, String? password, String? pin}) async => currentUser;

  @override
  Future<User?> register({
    String? email,
    String? phone,
    String? password,
    String? pin,
    String? name,
    String? firstName,
    String? lastName,
    String? village,
    String? county,
  }) async =>
      currentUser;

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
  Future<AuthStatus> checkAuthStatus() async => status;

  @override
  Future<bool> forgotPassword(String phone) async => true;

  @override
  Future<User?> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? village,
    String? county,
  }) async =>
      currentUser;
}

Future<void> _loadFonts() async {
  for (final family in const ['Poppins', 'Outfit']) {
    for (final asset in const ['Poppins-Regular.ttf', 'Poppins-Medium.ttf', 'Poppins-Bold.ttf']) {
      final bytes = File('fonts/$asset').readAsBytesSync();
      final loader = FontLoader(family)
        ..addFont(Future.value(ByteData.view(bytes.buffer)));
      await loader.load();
    }
  }
}

Future<void> _pumpApp(WidgetTester tester, AuthStatus status, {User? user}) async {
  await initDI();
  getIt.allowReassignment = true;
  getIt.registerLazySingleton<AuthProvider>(
    () => AuthProvider(_FakeAuthService(status, user)),
  );
  await _loadFonts();
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(const App());
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump(const Duration(milliseconds: 100));
}

void main() {
  testWidgets('unauthenticated user lands on login', (tester) async {
    await _pumpApp(tester, AuthStatus.unauthenticated);

    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('authenticated user lands on the today page', (tester) async {
    const user = User(id: 'uuid-1', email: 'a@b.com', firstName: 'Jane');
    await _pumpApp(tester, AuthStatus.authenticated, user: user);

    expect(find.byType(TodayPage), findsOneWidget);
  });
}