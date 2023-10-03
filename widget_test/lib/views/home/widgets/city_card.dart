import 'package:flutter/material.dart';
import 'package:widget_test/models/city_model.dart';
import 'package:widget_test/routes/routes.dart';

class CityCard extends StatelessWidget {
  const CityCard({super.key, required this.city});

  final City city;
  // final String name;
  // final String image;
  // final bool checked;
  // final VoidCallback updateChecked;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              child: Hero(
                tag: city.name,
                child: Image.network(
                  city.image,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.cityView,
                  arguments: city.name,
                );
              },
            ),
            // Ink.image(
            //   fit: BoxFit.cover,
            //   image: NetworkImage(city.image),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.pushNamed(
            //         context,
            //         AppRoute.cityView,
            //         arguments: city.name,
            //       );
            //     },
            //   ),
            // ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                color: Colors.black54,
                child: Text(
                  city.name,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: Column(
            //     children: [
            //       Expanded(
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Icon(
            //               checked ? Icons.star : Icons.star_border,
            //               size: 40,
            //               color: Colors.white,
            //             )
            //           ],
            //         ),
            //       ),
            //       Row(
            //         children: [
            //           Text(
            //             city.name,
            //             style: const TextStyle(
            //               color: Colors.white,
            //               fontSize: 30,
            //             ),
            //           )
            //         ],
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
