import 'package:flutter/material.dart';
import 'package:widget_test/models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    required this.activity,
    required this.isSelected,
    required this.toogleActivity,
  });

  final Activity activity;
  final VoidCallback toogleActivity;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.all(5),
      height: 250,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Ink.image(
            image: NetworkImage(activity.image),
            fit: BoxFit.cover,
            child: InkWell(
              onTap: toogleActivity,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (isSelected)
                        const Icon(
                          Icons.check,
                          size: 40,
                          color: Colors.yellow,
                        )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          activity.name,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
    // return ListTile(
    //   leading: CircleAvatar(backgroundImage: AssetImage(activity.image)),
    //   title: Text(activity.name),
    //   subtitle: Text(activity.city),
    //   trailing: Checkbox(
    //     value: true,
    //     tristate: true,
    //     activeColor: Colors.black,
    //     onChanged: (value) {},
    //   ),
    // );
  }
}
