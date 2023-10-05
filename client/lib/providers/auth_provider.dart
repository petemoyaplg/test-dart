import 'dart:convert';

import 'package:client/models/signup_form_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../env/env.dart' as env;
import '../models/signin_form_model.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  bool isLOaing = false;
  String? token;

  Future<dynamic> signup(SignUpForm signUpForm) async {
    try {
      isLOaing = true;
      Uri uri = Uri.http(env.host, 'api/user');
      http.Response response = await http.post(
        uri,
        body: json.encode(signUpForm.toJson()),
        headers: {'Content-type': 'application/json'},
      );
      if (response.statusCode != 200) {
        isLOaing = false;
        return json.decode(response.body);
      }
      isLOaing = false;
      return null;
    } catch (e) {
      isLOaing = false;
      rethrow;
    }
  }

  Future<dynamic> signin(SignInForm signInForm) async {
    try {
      isLOaing = true;
      Uri uri = Uri.http(env.host, 'api/auth');
      http.Response response = await http.post(
        uri,
        body: json.encode(signInForm.toJson()),
        headers: {'Content-type': 'application/json'},
      );

      final Map<String, dynamic> body = json.decode(response.body);

      if (response.statusCode == 200) {
        isLOaing = false;
        final User user = User.fromJson(body['user']);
        token = body['token'];
        return user;
      } else {
        isLOaing = false;
        return body;
      }
    } catch (e) {
      isLOaing = false;
      rethrow;
    }
  }

  Future<dynamic> signout() async {
    try {
      isLOaing = true;
      Uri uri = Uri.http(env.host, 'api/signout');
      token = null;
    } catch (e) {
      isLOaing = false;
      rethrow;
    }
  }
}
