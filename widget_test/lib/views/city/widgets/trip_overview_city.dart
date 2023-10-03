import 'package:flutter/material.dart';

class TripOverviewCity extends StatelessWidget {
  const TripOverviewCity({
    super.key,
    required this.cityName,
    required this.cityImage,
  });

  final String cityName;
  final String cityImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Hero(
            tag: cityName,
            child: Image.network(
              cityImage,
              fit: BoxFit.cover,
            ),
          ),
          // Image.network(cityImage, fit: BoxFit.cover),
          Container(color: Colors.black45),
          Center(
            child: Text(
              cityName,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
