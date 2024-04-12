import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  String? _idToken;
  String? _email;
  String? _uid;
  DateTime? _expiresIn;

  bool get isAuth {
    final isValid = _expiresIn?.isAfter(DateTime.now()) ?? false;

    return _idToken != null && isValid;
  }

  String? get idToken => isAuth ? _idToken : null;
  String? get email => isAuth ? _email : null;
  String? get uid => isAuth ? _uid : null;

  Future<void> _authenticate(
      String email, String password, String urlMethod) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlMethod?key=AIzaSyCEGVLgbMSckKrdux1CoazdbG_bChcuTAE';

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
      _uid = body['localId'];
      _expiresIn =
          DateTime.now().add(Duration(seconds: int.parse(body['expiresIn'])));
      notifyListeners();
    }

    print(body);
  }

  Future<void> singUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
