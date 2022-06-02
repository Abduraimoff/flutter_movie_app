// ignore_for_file: avoid_print
import 'dart:async';
import 'package:flutter/material.dart';
import '../data_provider/session_data_provider.dart';
import '../domain/api_client/api_client.dart';

class AuthProvider extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMesssage;
  String? get errorMesssage => _errorMesssage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMesssage = 'Enter login or password';
      notifyListeners();
      return;
    }
    _errorMesssage = null;
    _isAuthProgress = true;
    notifyListeners();

    String? sessionId;
    try {
      final sessionId =
          await _apiClient.auth(username: login, password: password);
    } catch (e) {
      _errorMesssage = '$e';
    }
    print(sessionId);
    _isAuthProgress = false;

    if (_errorMesssage != null) {
      notifyListeners();
      return;
    }

    if (sessionId == null) {
      _errorMesssage = 'Unknown error, please try again';
      notifyListeners();
      return;
    }

    await _sessionDataProvider.setSessionId(sessionId);

    // unawaited(Navigator.of(context).pushReplacementNamed('/main'));a
  }
}
