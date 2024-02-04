import 'dart:io';

import 'package:favorite_places/data/places_data.dart';
import 'package:favorite_places/models/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDataBase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
      path.join(dbPath,
          'places.db'), // places is the name of the database i am creating  a database named places here
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TITLE , image TEXT )');
  }, version: 1);
  return db;
}

class PlacesNotifier extends StateNotifier<List<Places>> {
  PlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDataBase();
    final data = await db.query('user_places');
    final places = data
        .map((row) => Places(
            placesId: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String)))
        .toList();
    state = places;
  }

  void addPlaces(String title, File selectedImage) async {
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(selectedImage.path);
    final copiedImage = await selectedImage.copy("${appDir.path}/$fileName");
    final newPlace = Places(title: title, image: selectedImage);
    final db = await _getDataBase();

    db.insert("user_places", {
      'id': newPlace.placesId,
      'title': newPlace.title,
      'image': newPlace.image.path
    });

    state = [newPlace, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Places>>(
    (ref) => PlacesNotifier());
