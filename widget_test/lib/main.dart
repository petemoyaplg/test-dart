// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test/not_found/not_found.dart';
import 'package:widget_test/models/city_model.dart';
import 'package:widget_test/routes/routes.dart';
import 'package:widget_test/views/activity-form/activity_form_view.dart';
import 'package:widget_test/views/city/city_view.dart';
import 'package:widget_test/views/google_map/google_map_view.dart';
import 'package:widget_test/views/home/home_view.dart';
import 'package:widget_test/views/trips/trips_view.dart';
// import '../../data/data.dart' as data;
import 'models/trip_model.dart';
import 'providers/city_provider.dart';
import 'providers/trip_provider.dart';
import 'views/trip/trip_view.dart';

void main() {
  runApp(DymaTrip());
  // runApp(themeTest());
}

class DymaTrip extends StatefulWidget {
  DymaTrip({super.key});

  final List<City> cities = [];

  @override
  State<DymaTrip> createState() => _DymaTripState();
}

class _DymaTripState extends State<DymaTrip> {
  CityProvider cityProvider = CityProvider();
  TripProvider tripProvider = TripProvider();

  @override
  void initState() {
    cityProvider.fetchData();
    tripProvider.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => CityProvider()),
        // ChangeNotifierProvider(create: (context) => TripProvider()),
        ChangeNotifierProvider.value(value: cityProvider),
        ChangeNotifierProvider.value(value: tripProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   appBarTheme: const AppBarTheme(titleTextStyle: TextStyle(fontSize: 30)),
        //   primarySwatch: Colors.red,
        //   textTheme: const TextTheme(
        //     bodyLarge: TextStyle(color: Colors.green),
        //   ),
        // ),
        // home: const HomeView(),
        // initialRoute: '/',
        routes: {
          AppRoute.homeView: (_) => const HomeView(),
          AppRoute.cityView: (_) => const CityView(),
          AppRoute.tripView: (_) => const TripView(),
          AppRoute.tripsView: (_) => const TripsView(),
          AppRoute.activityView: (_) => const ActivityFormView(),
          AppRoute.googleMapView: (_) => const GoogleMapView(),
        },
        // onGenerateRoute: (settings) {
        //   print(settings);
        //   switch (settings.name) {
        //     case AppRoute.cityView:
        //       {
        //         final City city = settings.arguments as City;
        //         return MaterialPageRoute(
        //           builder: (context) => CityView(
        //             city: city,
        //             addTrip: addTrip,
        //           ),
        //         );
        //       }
        //     case AppRoute.tripsView:
        //       {
        //         return MaterialPageRoute(
        //           builder: (context) => TripsView(trips: trips),
        //         );
        //       }
        //     case AppRoute.tripView:
        //       {
        //         String tripId = (settings.arguments
        //             as Map<String, String?>)['tripId'] as String;
        //         String cityName = (settings.arguments
        //             as Map<String, String?>)['cityName'] as String;
        //         return MaterialPageRoute(
        //           builder: (context) => TripView(
        //             trip: trips.firstWhere((trip) => trip.id == tripId),
        //             city:
        //                 widget.cities.firstWhere((city) => city.name == cityName),
        //           ),
        //         );
        //       }
        //   }
        //   return null;
        // },
        onUnknownRoute: (_) {
          return MaterialPageRoute(builder: (context) => const NotFound());
        },
        // home: Data(child: City()),
        // home: City(),
      ),
    );
  }
}

class TEST extends StatelessWidget {
  const TEST({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 700.0,
          maxWidth: 700.0,
        ),
        padding: const EdgeInsets.all(190),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        child: const Text("R",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 30.0,
            )),
      ),
    );
  }
}

MaterialApp themeTest() => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Un titre'),
        ),
        body: const Center(
          child: Text('Hello !'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Text('Test'),
          onPressed: () => {},
        ),
      ),
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
        fontFamily: 'Montserrat',
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan[600]),
        appBarTheme: const AppBarTheme(
            titleTextStyle:
                TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic)),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 28.0),
        ),
      ),
    );
