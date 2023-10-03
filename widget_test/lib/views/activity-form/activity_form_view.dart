import 'package:flutter/material.dart';
import 'package:widget_test/views/activity-form/widgets/activity_form.dart';
import 'package:widget_test/widgets/drawer.dart';

class ActivityFormView extends StatelessWidget {
  const ActivityFormView({super.key});

  @override
  Widget build(BuildContext context) {
    String cityName = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('ajouter une activité')),
      drawer: const DymaDrawer(),
      body: SingleChildScrollView(child: ActivityForm(cityName: cityName)),
    );
  }
}
