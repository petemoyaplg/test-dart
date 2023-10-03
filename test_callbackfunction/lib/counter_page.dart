import 'package:flutter/material.dart';
import 'count.dart';

class CounterPage extends StatefulWidget {
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: const Text("Widget Communication")),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  date.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  ).then((newDate) {
                    if (newDate != null) {
                      setState(() {
                        date = newDate;
                      });
                    }
                  });
                },
                child: const Text('Selectionner une date'),
              )
            ],
          ),
          Center(
              child: Count(
            count: count,
            onCountSelected: () {
              print("Count was selected.");
            },
            onCountChanged: (int val) {
              setState(() => count += val);
            },
          )),
        ],
      ),
    );
  }
}
