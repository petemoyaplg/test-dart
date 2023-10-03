import 'package:flutter/material.dart';

class SingUpView extends StatelessWidget {
  const SingUpView({super.key});

  static String routName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Text('SingUpView !'),
      ),
    );
  }
}
