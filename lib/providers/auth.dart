import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuthenticated {
    return token != null;
  }

  get userId {
    return _userId;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  void logout() {
    if (_authTimer != null) _authTimer.cancel();

    _token = null;
    _expiryDate = null;
    _userId = null;
    _authTimer = null;

    notifyListeners();
  }

  Future<bool> authenticate(String email, String password, bool login) async {
    var success = false;
    try {
      final api = login
          ? 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBg66KgjCjYWBuBvEiLKCGid1FtIS0OwfM'
          : 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBg66KgjCjYWBuBvEiLKCGid1FtIS0OwfM';

      final response = await http.post(
        api,
        body: jsonEncode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseBody = jsonDecode(response.body);

      if (responseBody['error'] == null) {
        _token = responseBody['idToken'];
        _expiryDate = DateTime.now()
            .add(Duration(seconds: int.parse(responseBody['expiresIn'])));
        _userId = responseBody['localId'];
        success = true;

        _autoLogout();
      } else
        throw HttpException(responseBody['error']['message']);

      notifyListeners();

      return success;
    } catch (e) {
      throw e;
    }
  }

  void _autoLogout() {
    final duration = _expiryDate.difference(DateTime.now()).inSeconds;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    _authTimer = Timer(
      Duration(
        seconds: duration,
      ),
      logout,
    );
  }
}
