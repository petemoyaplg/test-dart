import 'package:client/views/not_found_view.dart';
import 'package:flutter/material.dart';

import 'views/home_view.dart';

void main() {
  runApp(const MyAuth());
}

class MyAuth extends StatelessWidget {
  const MyAuth({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Auth',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomeView(),
      onGenerateRoute: (settings) {},
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const NotFoundView()),
    );
  }
}
