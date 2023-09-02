import 'package:favourite_places_app/config.dart';
import 'package:favourite_places_app/constants/navigation.dart';
import 'package:favourite_places_app/models/place.dart';
import 'package:favourite_places_app/screens/map.dart';
import 'package:favourite_places_app/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceDetailsScreen extends ConsumerWidget {
  final Place place;
  const PlaceDetailsScreen({
    super.key,
    required this.place,
  });

  String get locationImage {
    final lat = place.location.lat;
    final lng = place.location.lng;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=${Config.apiKey}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MainAppBar(title: place.placeName),
      body: Stack(
        children: [
          Image.file(
            place.placeImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    defaultNavigate(
                        context,
                        MapScreen(
                          placeLocation: place.location,
                          isSelecting: false,
                        ));
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(locationImage),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black45,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    place.location.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
