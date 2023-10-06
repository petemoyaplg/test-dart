import 'package:client/views/auth/signin_view.dart';
import 'package:client/views/not_found_view.dart';
import 'package:client/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/user_provide.dart';
import 'views/auth/signup_view.dart';
import 'views/home_view.dart';
import 'views/profile_view.dart';

void main() {
  runApp(const MyAuth());
}

class MyAuth extends StatefulWidget {
  const MyAuth({super.key});

  @override
  State<MyAuth> createState() => _MyAuthState();
}

class _MyAuthState extends State<MyAuth> {
  final AuthProvider authProvider = AuthProvider();

  // final UserProvider userProvider = UserProvider();

  @override
  void initState() {
    authProvider.initAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (_) => UserProvider(),
          update: (_, authProvider, oldUserProvider) {
            oldUserProvider?.update(authProvider);
            return oldUserProvider!;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Auth',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        // home: const SplashView(),
        home: const HomeView(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case HomeView.routName:
              {
                return MaterialPageRoute(
                  builder: (context) => const HomeView(),
                );
              }
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
