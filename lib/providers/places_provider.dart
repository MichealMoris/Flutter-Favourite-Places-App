import 'dart:io';

import 'package:favourite_places_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1,
  );
  return db;
}

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('places');
    final places = data
        .map((row) => Place(
            id: row['id'] as String,
            placeName: row['title'] as String,
            placeImage: File(row['image'] as String),
            location: PlaceLocation(
                lat: row['lat'] as double,
                lng: row['lng'] as double,
                address: row['address'] as String)))
        .toList();

    state = places;
  }

  void addPlace(Place place) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(place.placeImage.path);
    final copiedImage = await place.placeImage.copy('${appDir.path}/$filename');

    final newPlace = Place(
        placeName: place.placeName,
        placeImage: copiedImage,
        location: place.location);

    final db = await _getDatabase();

    db.insert('places', {
      'id': newPlace.id,
      'title': newPlace.placeName,
      'image': newPlace.placeImage.path,
      'lat': newPlace.location.lat,
      'lng': newPlace.location.lng,
      'address': newPlace.location.address,
    });

    state = [
      ...state,
      place,
    ];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
