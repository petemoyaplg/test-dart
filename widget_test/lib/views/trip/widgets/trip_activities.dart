import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test/views/trip/widgets/trip_activities_list.dart';

import '../../../models/activity_model.dart';
import '../../../models/trip_model.dart';
import '../../../providers/trip_provider.dart';

class TripActivities extends StatelessWidget {
  const TripActivities({super.key, required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context) {
    print("BUILD : TRIP_ACTIVITIES");

    return Container(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                tabs: const [Tab(text: 'En cours'), Tab(text: 'Terminé')],
                indicatorColor: Colors.blue[100],
              ),
            ),
            Container(
              height: 600,
              child: TabBarView(
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  TripActivitiesList(
                    tripId: tripId,
                    filter: ActivityStatus.ongoing,
                  ),
                  TripActivitiesList(
                    tripId: tripId,
                    filter: ActivityStatus.done,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
