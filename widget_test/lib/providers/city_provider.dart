import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

// import '../../../data/data.dart' as data;
import '../models/activity_model.dart';
import '../models/city_model.dart';
import 'package:http/http.dart' as http;
import '../env/env.dart' as env;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class CityProvider with ChangeNotifier {
  List<City> _cities = [];
  bool isLOading = false;

  UnmodifiableListView<City> get cities => UnmodifiableListView(_cities);

  City getCityByName(String cityName) =>
      cities.firstWhere((city) => city.name == cityName);

  Future<void> fetchData() async {
    try {
      isLOading = true;
      http.Response response =
          await http.get(Uri.http(env.host, '/api/cities'));
      if (response.statusCode == 200) {
        _cities = (json.decode(response.body) as List)
            .map((cityJson) => City.fromJson(cityJson))
            .toList();
        isLOading = false;
        notifyListeners();
      }
    } catch (e) {
      isLOading = false;
      rethrow;
    }
  }

  Future<void> addActivityToCity(Activity activity) async {
    City city = getCityByName(activity.city);

    try {
      Uri uri = Uri.http(env.host, '/api/city/${city.id}/activity');
      print(uri);
      http.Response response = await http.post(
        uri,
        body: json.encode(activity.toJson()),
        headers: {'Content-type': 'application/json'},
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        int index = _cities.indexWhere((item) => item.id == city.id);
        _cities[index] = City.fromJson(json.decode(response.body));
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  UnmodifiableListView<City> getFilteredCities(String text) =>
      UnmodifiableListView(
        cities
            .where(
                (city) => city.name.toLowerCase().contains(text.toLowerCase()))
            .toList(),
      );

  Future<dynamic> verifyIfActivityNameIsUnique(
      String cityName, String activityName) async {
    try {
      City city = getCityByName(cityName);
      Uri uri = Uri.http(
        env.host,
        '/api/city/${city.id}/activities/verify/$activityName',
      );
      http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploaImage(File pickedFile) async {
    try {
      Uri uri = Uri.http(env.host, '/api/activity/image');
      MultipartRequest request = http.MultipartRequest('POST', uri);

      request.files.add(
        http.MultipartFile.fromBytes(
          'activity',
          pickedFile.readAsBytesSync(),
          filename: basename(pickedFile.path),
          contentType: MediaType('multipart', 'form-data'),
        ),
      );

      StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        Uint8List responseData = await response.stream.toBytes();
        print(responseData);
        String value = String.fromCharCodes(responseData);
        print(value);
        return json.decode(value);
      } else {
        throw 'error';
      }
    } catch (e) {
      rethrow;
    }

    return '';
  }
}
