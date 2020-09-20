import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> logout() async {
    if (_authTimer != null) _authTimer.cancel();

    _token = null;
    _expiryDate = null;
    _userId = null;
    _authTimer = null;

    final prefInstance = await SharedPreferences.getInstance();
    await prefInstance.remove('userData');

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

      final prefInstance = await SharedPreferences.getInstance();
      final userData = jsonEncode({
        'token': _token,
        'expiryDate': _expiryDate.toIso8601String(),
        'userId': _userId,
      });

      await prefInstance.setString('userData', userData);

      return success;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefInstance = await SharedPreferences.getInstance();

    if (!prefInstance.containsKey('userData')) return false;

    final userData = jsonDecode(prefInstance.getString('userData'));
    final expiryDate = DateTime.parse(userData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) return false;

    _expiryDate = expiryDate;
    _userId = userData['userId'];
    _token = userData['token'];

    _autoLogout();

    notifyListeners();

    return true;
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
