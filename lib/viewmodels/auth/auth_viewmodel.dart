import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pennypath/models/auth_state.dart';
import 'package:pennypath/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  String? _token;
  String? _userId;
  String? _name;
  AuthState _authState = AuthState.unauthenticated;
  String? _errorMessage;

  String? get token => _token;
  String? get userId => _userId;
  String? get name => _name;
  AuthState get authState => _authState;
  String? get errorMessage => _errorMessage;

  AuthViewModel() {
    _initAuth();
  }

  Future<void> _initAuth() async {
    _token = await _secureStorage.read(key: 'token');
    _userId = await _secureStorage.read(key: 'userId');
    _name = await _secureStorage.read(key: 'name');
    if (_token != null && _userId != null) {
      _authState = AuthState.authenticated;
    } else {
      _authState = AuthState.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _authState = AuthState.authenticating;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.login(email, password);
      _token = response['token'];
      _userId = response['userId'];
      _name = response['name'];
      await _secureStorage.write(key: 'token', value: _token);
      await _secureStorage.write(key: 'userId', value: _userId);
      await _secureStorage.write(key: 'name', value: _name);
      _authState = AuthState.authenticated;
    } catch (e) {
      _authState = AuthState.error;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> signup(String name, String email, String password) async {
    _authState = AuthState.authenticating;
    _errorMessage = null;
    notifyListeners();

    try {
      await _apiService.signup(name, email, password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstLaunch', false);
      // After signup, log the user in to get a token
      await login(email, password);
    } catch (e) {
      _authState = AuthState.error;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    _authState = AuthState.requestingReset;
    _errorMessage = null;
    notifyListeners();

    try {
      await _apiService.forgotPassword(email);
      _authState = AuthState.resetSuccess;
    } catch (e) {
      _authState = AuthState.resetError;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> resetPassword(String token, String password) async {
    _authState = AuthState.resetting;
    _errorMessage = null;
    notifyListeners();

    try {
      await _apiService.resetPassword(token, password);
      _authState = AuthState.resetSuccess;
    } catch (e) {
      _authState = AuthState.resetError;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _name = null;
    await _secureStorage.deleteAll();
    _authState = AuthState.unauthenticated;
    notifyListeners();
  }
}