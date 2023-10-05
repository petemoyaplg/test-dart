class User {
  String id;
  String email;
  String username;

  User({
    required this.id,
    required this.email,
    required this.username,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        email = json['email'],
        username = json['username'];
}

// enum ActivityStatus { ongoing, done }

// class Activity {
//   String id;
//   String name;
//   String image;
//   String city;
//   double price;
//   LocationActivity? location;
//   ActivityStatus status;

//   Activity({
//     this.id = '',
//     required this.name,
//     required this.image,
//     required this.city,
//     required this.price,
//     this.location,
//     this.status = ActivityStatus.ongoing,
//   });

//   Activity.fromJson(Map<String, dynamic> json)
//       : id = json['_id'],
//         name = json['name'],
//         image = json['image'],
//         city = json['city'],
//         price = json['price'].toDouble(),
//         location = LocationActivity(
//           address: json['address'],
//           latitude: json['latitude'],
//           longitude: json['longitude'],
//         ),
//         status =
//             json['status'] == 0 ? ActivityStatus.ongoing : ActivityStatus.done;

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> value = {
//       'name': name,
//       'image': image,
//       'city': city,
//       'price': price,
//       'address': location?.address,
//       'longitude': location?.longitude,
//       'latitude': location?.latitude,
//       'status': status == ActivityStatus.ongoing ? 0 : 1
//     };
//     if (id != null) {
//       value['_id'] = id;
//     }
//     return value;
//   }
// }

// class LocationActivity {
//   String? address;
//   double? longitude;
//   double? latitude;

//   LocationActivity({
//     this.address,
//     this.longitude,
//     this.latitude,
//   });
// }

