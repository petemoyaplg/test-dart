import 'package:flutter/material.dart';
import 'package:widget_test/models/activity_model.dart';
import 'package:widget_test/views/city/widgets/activity.card.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({
    super.key,
    required this.activities,
    required this.selectedActivities,
    required this.toogleActivity,
  });

  final List<Activity> activities;
  final List<Activity> selectedActivities;
  final Function toogleActivity;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      children: activities
          .map(
            (e) => ActivityCard(
              activity: e,
              isSelected: selectedActivities.contains(e),
              toogleActivity: () {
                toogleActivity(e);
              },
            ),
          )
          .toList(),
    );
  }
}
