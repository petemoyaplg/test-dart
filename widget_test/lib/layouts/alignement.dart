import 'package:flutter/material.dart';

class ALIGNEMENT extends StatelessWidget {
  const ALIGNEMENT({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Container(
                color: Colors.red,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.blue,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.green,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.yellow,
                height: 100,
                width: 100,
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection: TextDirection.ltr,
            children: [
              Container(
                color: Colors.red,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.blue,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.green,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.yellow,
                height: 100,
                width: 100,
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.ltr,
            children: [
              Container(
                color: Colors.red,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.blue,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.green,
                height: 100,
                width: 100,
              ),
              Container(
                color: Colors.yellow,
                height: 100,
                width: 100,
              )
            ],
          )
        ]);
  }
}
