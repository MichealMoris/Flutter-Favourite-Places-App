import 'package:favourite_places_app/models/place.dart';
import 'package:favourite_places_app/widgets/places_list/places_list_item.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;
  const PlacesList({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return PlacesListItem(place: places[index]);
      },
    );
  }
}
