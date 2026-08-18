import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();

  bool _isAuthenticated = false;
  String? _currentUserId;
  String? _currentUserName;

  AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  bool get isAuthenticated => _isAuthenticated;
  String? get currentUserId => _currentUserId;
  String? get currentUserName => _currentUserName;

  Future<bool> signIn(String userId, String password) async {
    // Mock authentication
    await Future.delayed(const Duration(milliseconds: 500));
    _isAuthenticated = true;
    _currentUserId = userId;
    _currentUserName = 'ASHA Worker';
    notifyListeners();
    return true;
  }

  Future<bool> signUp(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    // Mock signup
    await Future.delayed(const Duration(milliseconds: 500));
    _isAuthenticated = true;
    _currentUserId = email;
    _currentUserName = name;
    notifyListeners();
    return true;
  }

  void logout() {
    _isAuthenticated = false;
    _currentUserId = null;
    _currentUserName = null;
    notifyListeners();
  }
}
