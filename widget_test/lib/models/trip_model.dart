import 'package:flutter/material.dart';
import 'package:widget_test/models/activity_model.dart';

class Trip {
  String id;
  String city;
  List<Activity> activities;
  DateTime date;
  Trip({
    required this.id,
    required this.city,
    required this.activities,
    required this.date,
  });

  Trip.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        city = json['city'],
        date = DateTime.parse(json['date']),
        activities = (json['activities'] as List)
            .map((activityJson) => Activity.fromJson(activityJson))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'city': city,
      'date': date.toIso8601String(),
      'activities': activities.map((e) => e.toJson()).toList(),
    };
  }
}
