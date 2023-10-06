import 'package:flutter/widgets.dart';

import '../models/user_model.dart';
import 'auth_provider.dart';

import 'dart:convert';

import 'package:client/models/signup_form_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../env/env.dart' as env;
import '../models/signin_form_model.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? user;
  late AuthProvider authProvider;

  void update(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    print('UPDATE USER');
    print('USER ${user == null}');
    print('TEST update ${authProvider.isLoggedin}');
    if (user == null && authProvider.isLoggedin!) {
      fetchCurrentUser();
    }
  }

  Future<void> fetchCurrentUser() async {
    print('FECTH USER');
    print('USER ${user == null}');
    print('TEST fetchCurrentUser ${authProvider.isLoggedin}');
    try {
      Uri uri = Uri.http(env.host, '/api/user/current');
      http.Response response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'autorization': 'Bearer ${authProvider.token}'
        },
      );
      print('=====================================');
      print('URI : $uri');
      print('=====================================');
      print('response.statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        User user = User.fromJson(json.decode(response.body));
        print('=====================================');
        print('USER : $user');
        updateUser(user);
      }
    } catch (e) {
      rethrow;
    }
  }

  void updateUser(User updatedUser) {
    user = updatedUser;
    notifyListeners();
  }
}
