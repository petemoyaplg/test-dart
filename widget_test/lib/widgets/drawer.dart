import 'package:flutter/material.dart';
import 'package:widget_test/routes/routes.dart';

class DymaDrawer extends StatelessWidget {
  const DymaDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            child: const Text(
              'Dymatrip',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Accueil'),
            onTap: () => Navigator.pushNamed(context, AppRoute.homeView),
          ),
          ListTile(
            leading: const Icon(Icons.flight),
            title: const Text('Mes voyages'),
            onTap: () => Navigator.pushNamed(context, AppRoute.tripsView),
          ),
        ],
      ),
    );
  }
}
