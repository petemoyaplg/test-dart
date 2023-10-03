import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test/models/city_model.dart';
import 'package:widget_test/models/trip_model.dart';
import 'package:widget_test/providers/city_provider.dart';
import 'package:widget_test/views/trip/widgets/trip_activities.dart';
import 'package:widget_test/views/trip/widgets/trip_city_bar.dart';

import '../../providers/trip_provider.dart';
import 'widgets/trip_weather.dart.dart';

class TripView extends StatelessWidget {
  const TripView({super.key});

  @override
  Widget build(BuildContext context) {
    print("BUILD : TRIP_VIEW");
    final String cityName = (ModalRoute.of(context)!.settings.arguments
        as Map<String, String?>)['cityName'] as String;
    final String tripId = (ModalRoute.of(context)!.settings.arguments
        as Map<String, String?>)['tripId'] as String;
    final City city = Provider.of<CityProvider>(context, listen: false)
        .getCityByName(cityName);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TripCityBar(city: city),
              TripWeather(cityName: cityName),
              TripActivities(tripId: tripId),
            ],
          ),
        ),
      ),
    );
  }
}
