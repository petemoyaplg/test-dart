import 'package:flutter/material.dart';
import 'package:widget_test/models/city_model.dart';

class TripCityBar extends StatelessWidget {
  const TripCityBar({super.key, required this.city});

  final City city;

  @override
  Widget build(BuildContext context) {
    print("BUILD : TRIP_CITY_BAR");
    return Container(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          // Image.asset(
          //   city.image,
          //   fit: BoxFit.cover,
          // ),
          Image.network(city.image, fit: BoxFit.cover),
          // NetworkImage(city.image),
          Container(
            color: Colors.black38,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
              children: [
                Row(children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  )
                ]),
                Expanded(
                    child: Center(
                  child: Text(
                    city.name,
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
