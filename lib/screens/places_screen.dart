import 'package:favourite_places_app/constants/navigation.dart';
import 'package:favourite_places_app/providers/places_provider.dart';
import 'package:favourite_places_app/screens/new_place_screen.dart';
import 'package:favourite_places_app/widgets/main_app_bar.dart';
import 'package:favourite_places_app/widgets/places_list/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    _placesFuture = ref.read(placesProvider.notifier).loadPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final placesList = ref.watch(placesProvider);
    return Scaffold(
      appBar: MainAppBar(
        title: 'Your Places',
        action: [
          IconButton(
            onPressed: () {
              defaultNavigate(context, const NewPlaceScreen());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: placesList.isEmpty
                ? Text(
                    'No places added yet.',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  )
                : FutureBuilder(
                    future: _placesFuture,
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? const Center(child: CircularProgressIndicator())
                            : PlacesList(
                                places: placesList,
                              ),
                  )),
      ),
    );
  }
}
