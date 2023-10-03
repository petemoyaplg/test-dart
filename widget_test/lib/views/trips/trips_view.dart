import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test/views/trips/widgets/trip_list.dart';
import 'package:widget_test/widgets/drawer.dart';
import 'package:widget_test/widgets/dyma_loader.dart';

import '../../models/trip_model.dart';
import '../../providers/trip_provider.dart';

class TripsView extends StatelessWidget {
  const TripsView({super.key});

  @override
  Widget build(BuildContext context) {
    TripProvider tripProvider = Provider.of<TripProvider>(context);
    List<Trip> trips = tripProvider.trips;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mes voyages'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'A venir'),
              Tab(text: 'Passés'),
            ],
          ),
        ),
        drawer: const DymaDrawer(),
        body: tripProvider.isLOading
            ? const DymaLoader()
            : trips.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    child: const Text('Aucun voyage pour le moment'),
                  )
                : TabBarView(
                    children: [
                      TripList(
                        trips: trips
                            .where((trip) => DateTime.now().isBefore(trip.date))
                            .toList(),
                      ),
                      TripList(
                        trips: trips
                            .where((trip) => DateTime.now().isAfter(trip.date))
                            .toList(),
                      ),
                    ],
                  ),
      ),
    );
  }
}
