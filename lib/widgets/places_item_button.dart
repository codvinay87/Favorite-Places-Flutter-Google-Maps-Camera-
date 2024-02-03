import 'package:favorite_places/providers/places_data_provider.dart';
import 'package:favorite_places/screens/places_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesItem extends ConsumerWidget {
  const PlacesItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesList = ref.watch(placesProvider);

    return ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(placesList[index].image),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => PlacesDetailsScreen(place: placesList[index])));
        },
        title: Text(
          placesList[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ));
  }
}
