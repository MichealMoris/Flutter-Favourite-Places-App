import 'package:favourite_places_app/constants/navigation.dart';
import 'package:favourite_places_app/models/place.dart';
import 'package:favourite_places_app/screens/place_details_scree.dart';
import 'package:flutter/material.dart';

class PlacesListItem extends StatelessWidget {
  final Place place;
  const PlacesListItem({
    super.key,
    required this.place,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        defaultNavigate(context, PlaceDetailsScreen(place: place));
      },
      leading: CircleAvatar(
        radius: 26,
        backgroundImage: FileImage(place.placeImage),
      ),
      title: Text(
        place.placeName,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        place.location.address,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );
  }
}
