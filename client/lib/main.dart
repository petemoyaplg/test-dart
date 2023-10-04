import 'package:client/views/auth/signin_view.dart';
import 'package:client/views/not_found_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'views/auth/signup_view.dart';
import 'views/home_view.dart';
import 'views/profile_view.dart';

void main() {
  runApp(MyAuth());
}

class MyAuth extends StatelessWidget {
  MyAuth({super.key});
  final AuthProvider authProvider = AuthProvider();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: authProvider)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Auth',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const HomeView(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case SingInView.routName:
              {
                return MaterialPageRoute(
                  builder: (context) => const SingInView(),
                );
              }
            case SingUpView.routName:
              {
                return MaterialPageRoute(
                  builder: (context) => const SingUpView(),
                );
              }
            case ProfileView.routName:
              {
                return MaterialPageRoute(
                  builder: (context) => const ProfileView(),
                );
              }
            default:
              {
                return MaterialPageRoute(
                    builder: (context) => const NotFoundView());
              }
          }
        },
      ),
    );
  }
}
