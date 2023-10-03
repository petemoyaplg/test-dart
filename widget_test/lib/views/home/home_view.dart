import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test/layouts/ask_modal.dart';
import 'package:widget_test/models/city_model.dart';
import 'package:widget_test/routes/routes.dart';
import 'package:widget_test/views/home/widgets/city_card.dart';
import 'package:widget_test/widgets/drawer.dart';
import 'package:widget_test/widgets/dyma_loader.dart';

import '../../providers/city_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  // final List<City> cities;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CityProvider cityProvider = Provider.of<CityProvider>(context);
    List<City> filteredCities =
        cityProvider.getFilteredCities(searchController.text);
    print('BUILD');
    return Scaffold(
      appBar: AppBar(title: const Text('dymatrip')),
      drawer: const DymaDrawer(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Rechercher une ville',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) {
                      print(value);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    searchController.clear();
                  },
                  icon: const Icon(Icons.clear),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: cityProvider.isLOading
                  ? const DymaLoader()
                  : filteredCities.isNotEmpty
                      ? RefreshIndicator(
                          onRefresh:
                              Provider.of<CityProvider>(context).fetchData,
                          child: ListView.builder(
                            itemCount: filteredCities.length,
                            itemBuilder: (_, i) {
                              City city = filteredCities[i];
                              return CityCard(city: city);
                            },
                          ),
                        )
                      : const Center(child: Text('Aucun résultat')),
            ),
          ),
        ],
      ),
    );
  }
}
