import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:client/models/signup_form_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../env/env.dart' as env;
import '../models/signin_form_model.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  bool isLoaing = false;
  bool isLoggedin = false;
  String? token;
  Timer? timer;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> initAuth() async {
    try {
      String? oldToken = await storage.read(key: 'token');
      if (oldToken == null) {
        isLoggedin = false;
      } else {
        token = oldToken;
        await refreshToken();
        if (token != null) {
          isLoggedin = true;
          iniTimer();
        } else {
          isLoggedin = false;
        }
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signup(SignUpForm signUpForm) async {
    try {
      isLoaing = true;
      Uri uri = Uri.http(env.host, 'api/user');
      http.Response response = await http.post(
        uri,
        body: json.encode(signUpForm.toJson()),
        headers: {'Content-type': 'application/json'},
      );
      if (response.statusCode != 200) {
        isLoaing = false;
        return json.decode(response.body);
      }
      isLoaing = false;
      return null;
    } catch (e) {
      isLoaing = false;
      rethrow;
    }
  }

  Future<dynamic> signin(SignInForm signInForm) async {
    try {
      isLoaing = true;
      Uri uri = Uri.http(env.host, 'api/auth');
      http.Response response = await http.post(
        uri,
        body: json.encode(signInForm.toJson()),
        headers: {'Content-type': 'application/json'},
      );

      final Map<String, dynamic> body = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoaing = false;
        final User user = User.fromJson(body['user']);
        token = body['token'];
        storage.write(key: 'token', value: token);
        isLoggedin = true;
        iniTimer();
        return user;
      } else {
        isLoaing = false;
        return body;
      }
    } catch (e) {
      isLoaing = false;
      rethrow;
    }
  }

  Future<dynamic> signout() async {
    isLoggedin = false;
    token = null;
    storage.delete(key: 'token');
    if (timer != null) {
      timer?.cancel();
    }
  }

  Future<void> refreshToken() async {
    try {
      Uri uri = Uri.http(env.host, 'api/auth/refresh-token');
      http.Response response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'autorization': 'Bearer $token'
        },
      );
      print('=========================================================');
      print('STATUS REFRESH TOKEN : ${response.statusCode}');
      if (response.statusCode == 200) {
        token = json.decode(response.body)['token'];
        storage.write(key: 'token', value: token);
        print('=========================================================');
        print('TOKEN : $token');
      } else {
        signout();
      }
    } catch (e) {
      rethrow;
    }
  }

  void iniTimer() {
    timer = Timer(const Duration(seconds: 5), () {
      refreshToken();
    });
  }

  void clearTimer() {}
}
