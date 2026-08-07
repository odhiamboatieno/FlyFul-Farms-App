import 'package:flutter/material.dart';
import 'package:flyful_farms/features/auth/domain/auth_service.dart';
import 'package:flyful_farms/features/auth/domain/auth_state.dart';
import 'package:flyful_farms/features/auth/domain/user.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _errorMessage;

  AuthStatus get status => _status;
  User? get user => _user;
  String? get errorMessage => _errorMessage;

  Future<void> checkAuthStatus() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      final result = await _authService.checkAuthStatus();
      _status = result;
      if (result == AuthStatus.authenticated) {
        _user = await _authService.getCurrentUser();
      } else {
        _user = null;
      }
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      _user = null;
    }
    notifyListeners();
  }

  Future<bool> login({
    String? email,
    String? phone,
    String? password,
    String? pin,
  }) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _authService.login(
        email: email,
        phone: phone,
        password: password,
        pin: pin,
      );

      if (user != null) {
        _user = user;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Invalid credentials';
        _status = AuthStatus.error;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred. Please try again.';
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
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
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _authService.register(
        phone: phone,
        email: email,
        password: password,
        pin: pin,
        name: name,
        firstName: firstName,
        lastName: lastName,
        village: village,
        county: county,
      );

      if (user != null) {
        _user = user;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Registration failed';
        _status = AuthStatus.error;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred. Please try again.';
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
