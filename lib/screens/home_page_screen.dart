import 'package:favorite_places/providers/places_data_provider.dart';
import 'package:favorite_places/screens/add_new_place_screen.dart';
import 'package:favorite_places/widgets/places_item_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesList = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Great Places"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddNewPlaceScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: placesList.isEmpty
          ? Center(
              child: Text(
              "No Places To Add",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ))
          : ListView.builder(
              itemCount: placesList.length,
              itemBuilder: (context, indexOfPlacesList) {
                return PlacesItem(
                  index: indexOfPlacesList,
                );
              },
            ),
    );
  }
}
