import 'package:widget_test/models/city_model.dart';

import '../models/activity_model.dart';
import '../models/trip_model.dart';

List<City> cities = [
  City(
    image: 'assets/paris.jpg',
    name: 'Paris',
    activities: parisActivities,
  ),
  City(
    image: 'assets/usa.jpg',
    name: 'USA',
    activities: usaActivities,
  ),
  City(
    image: 'assets/kinshasa.jpg',
    name: 'Kinshasa',
    activities: kinActivities,
  ),
];

List<Trip> trips = [
  // Trip(city: 'Paris', activities: cities[0].activities),
  // Trip(city: 'USA', activities: cities[1].activities),
  // Trip(
  //     city: 'Kinshasa',
  //     activities: cities[2].activities,
  //     date: DateTime.now().subtract(const Duration(days: 10))),
];

List<Activity> parisActivities = [
  Activity(
    image: 'assets/activities/louvre.jpg',
    name: 'Le Louvre',
    id: 'a1',
    city: 'Paris',
    price: 15.5,
  ),
  Activity(
    image: 'assets/activities/chaumont.jpg',
    name: 'Les buttes Chaumont',
    id: 'a2',
    city: 'Paris',
    price: 12.5,
  ),
  Activity(
    image: 'assets/activities/dame.jpg',
    name: 'Notre Dame',
    id: 'a3',
    city: 'Paris',
    price: 7.5,
  ),
  Activity(
    image: 'assets/activities/defense.jpg',
    name: 'La Défense',
    id: 'a4',
    city: 'Paris',
    price: 8.5,
  ),
  Activity(
    image: 'assets/activities/lyon.jpg',
    name: 'Lyon',
    id: 'a5',
    city: 'Paris',
    price: 18.00,
  ),
  Activity(
    image: 'assets/activities/marseille.jpg',
    name: 'Marseille',
    id: 'a6',
    city: 'Paris',
    price: 17.5,
  ),
  Activity(
    image: 'assets/activities/montpellier.jpg',
    name: 'Mont pellier',
    id: 'a7',
    city: 'Paris',
    price: 17.0,
  ),
  Activity(
    image: 'assets/activities/monaco.jpg',
    name: 'Monaco',
    id: 'a8',
    city: 'Paris',
    price: 17.5,
  ),
];
List<Activity> usaActivities = [
  Activity(
    image: 'assets/activities/atlanta.png',
    name: 'Atlanta',
    id: 'u1',
    city: 'USA',
    price: 25.5,
  ),
  Activity(
    image: 'assets/activities/hollywood.jpg',
    name: 'Hollywood',
    id: 'u2',
    city: 'USA',
    price: 32.5,
  ),
  Activity(
    image: 'assets/activities/new-york.jpg',
    name: 'New york',
    id: 'u3',
    city: 'USA',
    price: 77.5,
  ),
  Activity(
    image: 'assets/activities/miami.jpg',
    name: 'Miami',
    id: 'u4',
    city: 'USA',
    price: 200.5,
  ),
  Activity(
    image: 'assets/activities/philadelphie.jpg',
    name: 'Philadelphie',
    id: 'u7',
    city: 'USA',
    price: 85.75,
  ),
  Activity(
    image: 'assets/activities/mit.jpg',
    name: 'MIT',
    id: 'u5',
    city: 'USA',
    price: 99.5,
  ),
  Activity(
    image: 'assets/activities/las-vegas.jpg',
    name: 'Las Vegas',
    id: 'u6',
    city: 'USA',
    price: 185.75,
  ),
  Activity(
    image: 'assets/activities/Washington.jpg',
    name: 'Washington',
    id: 'u7',
    city: 'USA',
    price: 125.75,
  ),
];
List<Activity> kinActivities = [
  Activity(
    image: 'assets/activities/bandal.jpg',
    name: 'Bandal',
    id: 'k1',
    city: 'Kinshasa',
    price: 225.5,
  ),
  Activity(
    image:
        'assets/activities/girls-near-you-brazzaville-hook-up-nightlife-singles-bars.jpg',
    name: 'Gombe',
    id: 'k2',
    city: 'Kinshasa',
    price: 320.5,
  ),
  Activity(
    image: 'assets/activities/gombe1.jpeg',
    name: 'SOZACOM',
    id: 'k3',
    city: 'Kinshasa',
    price: 177.5,
  ),
  Activity(
    image: 'assets/activities/kintambo.jpg',
    name: 'Kintambo',
    id: 'k4',
    city: 'Kinshasa',
    price: 100.5,
  ),
  Activity(
    image: 'assets/activities/limete.jpg',
    name: 'Limete',
    id: 'k5',
    city: 'Kinshasa',
    price: 185.75,
  ),
  Activity(
    image: 'assets/activities/paserelle.jpg',
    name: 'Paserelle',
    id: 'k6',
    city: 'Kinshasa',
    price: 99.5,
  ),
  Activity(
    image: 'assets/activities/unikin.jpg',
    name: 'UNIKIN',
    id: 'k7',
    city: 'Kinshasa',
    price: 185.75,
    status: ActivityStatus.done,
  ),
];
