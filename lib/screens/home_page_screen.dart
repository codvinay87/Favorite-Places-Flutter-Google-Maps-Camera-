import 'package:favorite_places/providers/places_data_provider.dart';
import 'package:favorite_places/screens/add_new_place_screen.dart';
import 'package:favorite_places/widgets/places_item_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({super.key});

  @override
  ConsumerState<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  late Future<void> _placesFuture;
  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
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
          : RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 300));

                ref.watch(placesProvider);
              },
              child: ListView.builder(
                itemCount: placesList.length,
                itemBuilder: (context, indexOfPlacesList) {
                  return FutureBuilder(
                    future: _placesFuture,
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : PlacesItem(
                                index: indexOfPlacesList,
                              ),
                  );
                },
              ),
            ),
    );
  }
}
