import 'dart:io';

import 'package:favorite_places/models/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesNotifier extends StateNotifier<List<Places>> {
  PlacesNotifier() : super(const []);

  void addPlaces(String title, File selectedImage) {
    final newPlace = Places(title: title, image: selectedImage);
    state = [newPlace, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Places>>(
    (ref) => PlacesNotifier());
