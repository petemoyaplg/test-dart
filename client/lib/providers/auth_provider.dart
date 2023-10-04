import 'dart:convert';

import 'package:client/models/signup_form_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../env/env.dart' as env;

class AuthProvider with ChangeNotifier {
  bool isLOaing = false;

  Future<dynamic> signup(SignUpForm signUpForm) async {
    try {
      isLOaing = true;
      Uri uri = Uri.http(env.host, 'api/user');
      print(uri);
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
}
