import 'package:flutter/material.dart';
import 'package:widget_test/models/activity_model.dart';
import 'package:widget_test/views/city/widgets/trip.activity.card.dart';

class TripActivityList extends StatelessWidget {
  const TripActivityList({
    super.key,
    required this.activities,
    required this.deleteTripActivity,
  });

  final List<Activity> activities;
  final Function deleteTripActivity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, i) {
          Activity activity = activities[i];
          return TripActivityCard(
            key: ValueKey(activity.id),
            activity: activity,
            deleteTripActivity: deleteTripActivity,
          );
        },
        itemCount: activities.length,
      ),
      // child: ListView(
      //   children: activities
      //       .map(
      //         (e) => TripActivityCard(
      //           key: ValueKey(e.id),
      //           activity: e,
      //           deleteTripActivity: deleteTripActivity,
      //         ),
      //       )
      //       .toList(),
      // ),
    );
  }
}
