import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/app/app.dart';
import 'package:flyful_farms/config/di.dart';
import 'package:flyful_farms/features/auth/domain/auth_service.dart';
import 'package:flyful_farms/features/auth/domain/auth_state.dart';
import 'package:flyful_farms/features/auth/domain/user.dart';
import 'package:flyful_farms/features/auth/presentation/pages/login_page.dart';
import 'package:flyful_farms/features/auth/presentation/pages/register_page.dart';
import 'package:flyful_farms/features/auth/presentation/providers/auth_provider.dart';
import 'package:flyful_farms/features/dashboard/presentation/pages/today_page.dart';
import 'package:flyful_farms/features/feeding/presentation/pages/feed_type_page.dart';
import 'package:flyful_farms/features/jobs/presentation/pages/jobs_page.dart';

class _FakeAuthService implements AuthService {
  _FakeAuthService(this.status, this.currentUser);

  final AuthStatus status;
  final User? currentUser;
  int loginCalls = 0;
  int registerCalls = 0;

  @override
  Future<User?> login({String? email, String? phone, String? password, String? pin}) async {
    loginCalls++;
    return currentUser;
  }

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
  }) async {
    registerCalls++;
    return currentUser;
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
  for (final family in const ['Poppins']) {
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
  testWidgets('login page renders the redesigned form fields', (tester) async {
    await _pumpApp(tester, AuthStatus.unauthenticated);

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text("Don't have an account? Register"), findsOneWidget);
    expect(find.text('Forgot your password?'), findsOneWidget);
  });

  testWidgets('login form validates empty phone', (tester) async {
    await _pumpApp(tester, AuthStatus.unauthenticated);

    await tester.tap(find.text('LOGIN'));
    await tester.pump();

    expect(find.text('Please enter your phone number'), findsOneWidget);
  });

  testWidgets('register page does not show forgot password link', (tester) async {
    await _pumpApp(tester, AuthStatus.unauthenticated);

    await tester.tap(find.text("Don't have an account? Register"));
    await tester.pumpAndSettle();

    expect(find.byType(RegisterPage), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
    expect(find.text('Forgot your password?'), findsNothing);
  });

  testWidgets('authenticated user sees today page with jobs header', (tester) async {
    const user = User(id: 'uuid-1', email: 'a@b.com', firstName: 'Jane');
    await _pumpApp(tester, AuthStatus.authenticated, user: user);

    expect(find.byType(TodayPage), findsOneWidget);
    expect(find.text('Today’s work'), findsOneWidget);
  });

  testWidgets('tapping today header opens the jobs page', (tester) async {
    const user = User(id: 'uuid-1', email: 'a@b.com', firstName: 'Jane');
    await _pumpApp(tester, AuthStatus.authenticated, user: user);

    await tester.tap(find.text('Today’s work'));
    await tester.pumpAndSettle();

    expect(find.byType(JobsPage), findsOneWidget);
  });

  testWidgets('tapping do now opens the feed wizard', (tester) async {
    const user = User(id: 'uuid-1', email: 'a@b.com', firstName: 'Jane');
    await _pumpApp(tester, AuthStatus.authenticated, user: user);

    await tester.tap(find.text('START'));
    await tester.pumpAndSettle();

    expect(find.byType(FeedTypePage), findsOneWidget);
  });
}