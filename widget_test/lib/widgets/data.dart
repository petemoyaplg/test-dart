import 'package:flutter/material.dart';
import 'package:widget_test/models/activity_model.dart';
import '../data/data.dart' as data;

class Data extends InheritedWidget {
  late List<Activity> activities = data.parisActivities;

  Data({super.key, required super.child});

  // Data({super.key, required Widget child}) : super();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Data>();
  }
}
