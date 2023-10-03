import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test/models/activity_model.dart';
import 'package:widget_test/providers/trip_provider.dart';
import 'package:widget_test/routes/routes.dart';

import '../../../models/trip_model.dart';

class TripActivitiesList extends StatelessWidget {
  const TripActivitiesList({
    super.key,
    required this.tripId,
    required this.filter,
  });

  final String tripId;
  final ActivityStatus filter;

  @override
  Widget build(BuildContext context) {
    print("BUILD : TRIP_ACTIVITIES_LIST");

    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) {
        final Trip trip = tripProvider.getTripById(tripId);
        final List<Activity> activities = trip.activities
            .where((activity) => activity.status == filter)
            .toList();
        return ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, i) {
            Activity activity = activities[i];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: filter == ActivityStatus.ongoing
                  ? Dismissible(
                      key: ValueKey(activity.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.greenAccent[700],
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 30),
                      ),
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoute.googleMapView,
                          arguments: {
                            'activityId': activity.id,
                            'tripId': trip.id,
                          },
                        ),
                        child: Card(
                          child: ListTile(
                            title: Text(activity.name),
                          ),
                        ),
                      ),
                      confirmDismiss: (_) {
                        return Provider.of<TripProvider>(context, listen: false)
                            .updateTrip(trip, activity.id)
                            .then((_) => true)
                            .catchError((_) => false);
                      },
                      // onDismissed: (_) {
                      //   Provider.of<TripProvider>(context, listen: false)
                      //       .updateTrip(trip, activity.id);
                      // },
                    )
                  : Card(
                      child: ListTile(
                        title: Text(
                          activity.name,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
            );
          },
        );
      },
      child: const Text('123'),
    );
  }
}
