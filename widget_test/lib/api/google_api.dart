import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/activity_model.dart';
import '../models/places_model.dart';

const GOOGLE_KEY_API = 'YOUR KEY HERE';

Uri _queryAutocompleteBuilder(String query) {
  return Uri.parse(
      'https://maps.googleapis.com/maps/api/place/queryautocomplete/json?&key=$GOOGLE_KEY_API&input=$query');
}

Uri _queryPlaceDetailsBuilder(String placeId) {
  return Uri.parse(
      "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&fields=formatted_address,geometry&key=$GOOGLE_KEY_API");
}

Uri _queryGetAddressFromLatLngBuilder(
    {required double lat, required double lng}) {
  return Uri.parse(
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_KEY_API");
}

Future<List<Place>> getAutocompleteSuggestions(String query) async {
  try {
    var response = await http.get(_queryAutocompleteBuilder(query));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return (body['predictions'] as List)
          .map(
            (suggestion) => Place(
              description: suggestion['description'] ?? '',
              placeId: suggestion['place_id'] ?? '',
            ),
          )
          .toList();
    } else {
      return [];
    }
  } catch (e) {
    rethrow;
  }
}

Future<LocationActivity> getPlaceDetailsApi(String placeId) async {
  try {
    var response = await http.get(_queryPlaceDetailsBuilder(placeId));
    if (response.statusCode == 200) {
      var body = json.decode(response.body)['result'];
      return LocationActivity(
        address: body['formatted_address'],
        longitude: body['geometry']['location']['lng'],
        latitude: body['geometry']['location']['lat'],
      );
    } else {
      throw 'Erreur !';
    }
  } catch (e) {
    rethrow;
  }
}

Future<String> getAddressFromLatLng(
    {required double lat, required double lng}) async {
  try {
    var response =
        await http.get(_queryGetAddressFromLatLngBuilder(lat: lat, lng: lng));
    if (response.statusCode == 200) {
      return json.decode(response.body)['results'][0]['formatted_address'];
    } else {
      throw 'Erreur !';
    }
  } catch (e) {
    rethrow;
  }
}
