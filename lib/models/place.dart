import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double lat;
  final double lng;
  final String address;

  const PlaceLocation({
    required this.lat,
    required this.lng,
    required this.address,
  });
}

class Place {
  final String id;
  final String placeName;
  final File placeImage;
  final PlaceLocation location;

  Place({
    String? id,
    required this.placeName,
    required this.placeImage,
    required this.location,
  }) : id = id ?? uuid.v4();
}
