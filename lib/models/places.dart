import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Places {
  Places({required this.title, required this.image}) : placesId = uuid.v4();
  final String title;
  final String placesId;
  final File image;
}
