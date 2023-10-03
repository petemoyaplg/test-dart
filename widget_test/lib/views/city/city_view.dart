// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test/models/activity_model.dart';
import 'package:widget_test/models/city_model.dart';
import 'package:widget_test/models/trip_model.dart';
import 'package:widget_test/providers/city_provider.dart';
import 'package:widget_test/routes/routes.dart';
import 'package:widget_test/views/city/widgets/activity.list.dart';
import 'package:widget_test/views/city/widgets/trip.activity.list.dart';
import 'package:widget_test/views/city/widgets/trip.overview.dart';
import 'package:widget_test/widgets/drawer.dart';

import '../../providers/trip_provider.dart';

class CityView extends StatefulWidget {
  const CityView({super.key});

  showContext({required BuildContext context, required List<Widget> children}) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.landscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      );
    } else {
      return Column(children: children);
    }
  }

  @override
  State<CityView> createState() => _CityViewState();
}

class _CityViewState extends State<CityView> with WidgetsBindingObserver {
  late Trip mytrip;
  late int index;

  double get amount {
    return mytrip.activities.fold(0.0, (prev, element) {
      return prev + element.price;
    });
  }

  void setDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((newDate) {
      if (newDate != null) {
        setState(() {
          mytrip.date = newDate;
        });
      }
    });
  }

  void switchIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  void toogleActivity(Activity activity) {
    setState(() {
      mytrip.activities.contains(activity)
          ? mytrip.activities.remove(activity)
          : mytrip.activities.add(activity);
    });
  }

  void deleteTripActivity(Activity activity) {
    setState(() {
      mytrip.activities.remove(activity);
    });
  }

  void saveTrip(String cityName) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        // return SimpleDialog(
        //   title: const Text('Voulez-vous sauvegarder ?'),
        //   shape: RoundedRectangleBorder(
        //       side: const BorderSide(
        //         color: Colors.black,
        //       ),
        //       borderRadius: BorderRadius.circular(15)),
        //   children: [
        //     Row(
        //       children: [
        //         OutlinedButton(
        //           onPressed: () => Navigator.pop(context, 'cancel'),
        //           child: const Text('Annuler'),
        //         ),
        //         ElevatedButton(
        //           onPressed: () => Navigator.pop(context, 'save'),
        //           child: const Text('Sauvegarder'),
        //         ),
        //       ],
        //     )
        //   ],
        // );
        return CupertinoAlertDialog(
          title: const Icon(Icons.question_mark_rounded),
          content: const Text('Voulez-vous sauvegarder ?'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
            ),
            CupertinoDialogAction(
              child: const Text('Sauvegarder'),
              onPressed: () {
                Navigator.pop(context, 'save');
              },
            ),
          ],
        );
      },
    );

    if (mounted) {
      if (mytrip.date != null) {
        switch (result) {
          case 'save':
            // widget.addTrip(mytrip);
            mytrip.city = cityName;
            Provider.of<TripProvider>(context, listen: false).addTrip(mytrip);
            Navigator.pushNamed(context, AppRoute.homeView);
            break;
          default:
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Attention !'),
              content: const Text('Selectionnez une date'),
              actions: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok'),
                )
              ],
            );
          },
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    index = 0;
    mytrip = Trip(id: '', city: '', activities: [], date: DateTime.now());
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   activities = Data.of(context).activities;
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('============================================');
    print('STATE : $state');
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    // final City city = ModalRoute.of(context)!.settings.arguments as City;
    final String cityName =
        ModalRoute.of(context)!.settings.arguments as String;

    final City city =
        Provider.of<CityProvider>(context).getCityByName(cityName);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisation voyage'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoute.activityView,
              arguments: cityName,
            ),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const DymaDrawer(),
      body: Container(
          // padding: const EdgeInsets.all(10),
          // child: ListView.separated(
          //   itemCount: widget.activities.length,
          //   separatorBuilder: (context, index) {
          //     return const Divider(
          //       color: Colors.blue,
          //     );
          //   },
          //   itemBuilder: (context, index) {
          //     return ActivityCard(activity: widget.activities[index]);
          //   },
          // ),
          /*
          * GRIDVIEW.BUILDER 
        */
          // child: GridView.builder(
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //   ),
          //   itemCount: widget.activities.length,
          //   itemBuilder: (context, index) {
          //     return ActivityCard(activity: widget.activities[index]);
          //   },
          // ),
          // ),
          /*
          * GRIDVIEW.COUNT 
        */
          child: widget.showContext(
        context: context,
        children: [
          TripOverview(
            setDate: setDate,
            mytrip: mytrip,
            cityName: city.name,
            cityImage: city.image,
            amount: amount,
          ),
          Expanded(
            child: index == 0
                ? ActivityList(
                    activities: city.activities,
                    selectedActivities: mytrip.activities,
                    toogleActivity: toogleActivity,
                  )
                : TripActivityList(
                    activities: mytrip.activities,
                    deleteTripActivity: deleteTripActivity,
                  ),
          ),
        ],
      )
          /*
          * GRIDVIEW 
        */
          // child: GridView(
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //   ),
          //   // itemCount: widget.activities.length,
          //   children:
          //       widget.activities.map((e) => ActivityCard(activity: e)).toList(),
          // ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => saveTrip(city.name),
        child: const Icon(
          Icons.forward,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Decouvert',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            label: 'Mes activités',
          ),
        ],
        onTap: switchIndex,
      ),
    );
  }
}
