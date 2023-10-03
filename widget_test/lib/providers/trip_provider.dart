// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:widget_test/models/trip_model.dart';

// import '../../../data/data.dart' as data;
import '../models/activity_model.dart';
import 'package:http/http.dart' as http;
import '../env/env.dart' as env;

class TripProvider with ChangeNotifier {
  List<Trip> _trips = [];
  bool isLOading = false;

  UnmodifiableListView<Trip> get trips => UnmodifiableListView(_trips);

  Future<void> addTrip(Trip trip) async {
    try {
      Uri uri = Uri.http(env.host, '/api/trip');
      http.Response response = await http.post(
        uri,
        body: json.encode(trip.toJson()),
        headers: {'Content-type': 'application/json'},
      );
      if (response.statusCode == 200) {
        _trips.add(Trip.fromJson(json.decode(response.body)));
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Trip getTripById(String tripId) =>
      trips.firstWhere((trip) => trip.id == tripId);

  Future<void> updateTrip(Trip trip, String activityId) async {
    print({trip.id});
    print(trip.activities.firstWhere((e) => e.id == activityId).status);
    try {
      Activity activity = trip.activities.firstWhere((e) => e.id == activityId);
      activity.status = ActivityStatus.done;
      print({trip, activityId});
      print(trip.activities.firstWhere((e) => e.id == activityId).status);
      Uri uri = Uri.http(env.host, '/api/trip');
      print(trip.toJson());
      http.Response response = await http.put(
        uri,
        body: json.encode(trip.toJson()),
        headers: {'Content-type': 'application/json'},
      );
      print(response.statusCode);
      if (response.statusCode != 200) {
        activity.status = ActivityStatus.ongoing;
        throw const HttpException('Erreur');
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchData() async {
    try {
      isLOading = true;
      http.Response response = await http.get(Uri.http(env.host, '/api/trips'));
      if (response.statusCode == 200) {
        _trips = (json.decode(response.body) as List)
            .map((tripJson) => Trip.fromJson(tripJson))
            .toList();
        print(
            '====================================================================');
        print('TRIPS SIZE :${_trips.length}');
        isLOading = false;
        notifyListeners();
      }
    } catch (e) {
      isLOading = false;
      rethrow;
    }
  }

  Activity getActivityByIds({
    required String activityId,
    required String tripId,
  }) {
    return getTripById(tripId)
        .activities
        .firstWhere((activity) => activity.id == activityId);
  }
}
