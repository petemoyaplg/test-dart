import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:widget_test/models/trip_model.dart';

import 'trip_overview_city.dart';

class TripOverview extends StatelessWidget {
  const TripOverview({
    super.key,
    required this.setDate,
    required this.mytrip,
    required this.cityName,
    required this.cityImage,
    required this.amount,
  });

  final VoidCallback setDate;
  final Trip mytrip;
  final String cityName;
  final String cityImage;
  final double amount;

  // double get amount {
  //   return 0;
  // }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: orientation == Orientation.landscape
          ? size.width * .5
          : double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TripOverviewCity(cityName: cityName, cityImage: cityImage),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    mytrip.date != null
                        ? DateFormat('dd/MM/yyyy').format(mytrip.date!)
                        : 'Choisissez une date',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                OutlinedButton(
                  onPressed: setDate,
                  child: const Text('Selectionner une date'),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Montant / personne :',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text(
                  '$amount \$',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
