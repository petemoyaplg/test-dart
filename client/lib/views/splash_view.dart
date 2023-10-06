import 'package:client/providers/auth_provider.dart';
import 'package:client/views/home_view.dart';
import 'package:client/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static String routName = '/splash';

  @override
  Widget build(BuildContext context) {
    final bool isLoggedin =
        Provider.of<AuthProvider>(context, listen: false).isLoggedin;
    print('=========================================================');
    print('isLoggedin SplashView : $isLoggedin');
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (isLoggedin == false) {
        Navigator.pushReplacementNamed(context, HomeView.routName);
      } else if (isLoggedin == true) {
        Navigator.pushReplacementNamed(context, ProfileView.routName);
      }
    });

    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        alignment: Alignment.center,
        child: const Text(
          'Dyma',
          style: TextStyle(
            fontSize: 100,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
