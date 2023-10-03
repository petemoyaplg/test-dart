import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:widget_test/routes/routes.dart';

import '../../../models/trip_model.dart';

class TripList extends StatelessWidget {
  const TripList({super.key, required this.trips});

  final List<Trip> trips;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, i) {
        Trip trip = trips[i];
        return ListTile(
          title: Text(trip.city),
          subtitle: trip.date != null
              ? Text(
                  DateFormat('dd/MM/yyy').format(trip.date!),
                )
              : null,
          trailing: const Icon(Icons.info),
          onTap: () =>
              Navigator.pushNamed(context, AppRoute.tripView, arguments: {
            'tripId': trip.id,
            'cityName': trip.city,
          }),
        );
      },
    );
  }
}
