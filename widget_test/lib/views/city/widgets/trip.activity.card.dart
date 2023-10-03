import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_test/models/activity_model.dart';

class TripActivityCard extends StatefulWidget {
  const TripActivityCard({
    super.key,
    required this.activity,
    required this.deleteTripActivity,
  });

  final Activity activity;
  final Function deleteTripActivity;

  Color getColor() {
    const colors = [Colors.blue, Colors.red];
    return colors[Random().nextInt(2)];
  }

  @override
  State<TripActivityCard> createState() => _TripActivityCardState();
}

class _TripActivityCardState extends State<TripActivityCard> {
  late Color color;

  @override
  void initState() {
    color = widget.getColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(widget.activity.image),
      ),
      title: Text(
        widget.activity.name,
        style: TextStyle(color: color),
      ),
      subtitle: Text(widget.activity.city),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          widget.deleteTripActivity(widget.activity.id);
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text('Activité supprimée'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'Annuler',
                  textColor: Colors.white,
                  onPressed: () {
                    print('E=TEST');
                  },
                ),
              ),
            );
        },
      ),
    );
  }
}
