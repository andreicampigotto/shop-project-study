import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/constats.dart';

class Auth with ChangeNotifier {
  String? _idToken;
  String? _email;
  String? _userId;
  DateTime? _expiresIn;
  Timer? _logoutTimer;

  bool get isAuth {
    final isValid = _expiresIn?.isAfter(DateTime.now()) ?? false;

    return _idToken != null && isValid;
  }

  String? get idToken => isAuth ? _idToken : null;
  String? get email => isAuth ? _email : null;
  String? get userId => isAuth ? _userId : null;

  Future<void> _authenticate(
      String email, String password, String urlMethod) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlMethod?key=${Constants.webApiKey}';

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _idToken = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];
      _expiresIn =
          DateTime.now().add(Duration(seconds: int.parse(body['expiresIn'])));
      _autoLogout();
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  void logout() {
    _idToken = null;
    _email = null;
    _userId = null;
    _expiresIn = null;
    _clearAutoLogoutTimer();
    notifyListeners();
  }

  void _clearAutoLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    _clearAutoLogoutTimer();
    final logoutTime = _expiresIn?.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: logoutTime ?? 0), logout);
  }
}
