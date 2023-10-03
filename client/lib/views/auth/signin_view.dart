import 'package:flutter/material.dart';

class SingInView extends StatelessWidget {
  const SingInView({super.key});

  static String routName = '/signin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Text('SingInView !'),
      ),
    );
  }
}
