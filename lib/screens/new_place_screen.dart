import 'dart:io';

import 'package:favourite_places_app/constants/navigation.dart';
import 'package:favourite_places_app/models/place.dart';
import 'package:favourite_places_app/providers/places_provider.dart';
import 'package:favourite_places_app/widgets/image_input.dart';
import 'package:favourite_places_app/widgets/location_input.dart';
import 'package:favourite_places_app/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var enteredPlaceName = '';
    final placeProvider = ref.read(placesProvider.notifier);

    void addPlace() {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        formKey.currentState!.save();
        if (_selectedImage == null || _selectedLocation == null) {
          return;
        }
        placeProvider.addPlace(
          Place(
            placeName: enteredPlaceName,
            placeImage: _selectedImage!,
            location: _selectedLocation!,
          ),
        );
        defaultPop(context);
      }
    }

    return Scaffold(
      appBar: const MainAppBar(title: 'Add new Place'),
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  decoration: const InputDecoration(
                    label: Text('Place Name'),
                  ),
                  validator: (value) => value == null ||
                          value.trim().isEmpty ||
                          value.trim().length <= 1
                      ? 'Place Name Must be more than 1 character.'
                      : null,
                  onSaved: (newValue) => enteredPlaceName = newValue!,
                ),
                const SizedBox(
                  height: 10,
                ),
                ImageInput(
                  onPickImage: (image) => _selectedImage = image,
                ),
                const SizedBox(
                  height: 10,
                ),
                LocationInput(
                  onSelectLocation: (location) => _selectedLocation = location,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton.icon(
                  onPressed: addPlace,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Place'),
                ),
              ],
            ),
          )),
    );
  }
}
