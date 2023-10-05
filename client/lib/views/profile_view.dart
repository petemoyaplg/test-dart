import 'package:client/providers/auth_provider.dart';
import 'package:client/providers/user_provide.dart';
import 'package:client/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const String routName = '/profile';

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                user.username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              tileColor: Theme.of(context).primaryColor,
              leading: const Icon(Icons.logout_outlined),
              title: const Text(
                'Deconnexion',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).signout();
                Navigator.pushNamed(context, HomeView.routName);
              },
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text('ProfileView !'),
      ),
    );
  }
}
