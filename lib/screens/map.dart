import 'package:favourite_places_app/constants/navigation.dart';
import 'package:favourite_places_app/models/place.dart';
import 'package:favourite_places_app/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation placeLocation;
  final bool isSelecting;
  const MapScreen({
    super.key,
    this.placeLocation = const PlaceLocation(
      lat: 30.0444,
      lng: 31.2357,
      address: '',
    ),
    this.isSelecting = true,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: widget.isSelecting ? 'Pick your location' : 'Your Location',
        action: [
          if (widget.isSelecting)
            IconButton(
                onPressed: () {
                  defaultPop(context, result: _pickedLocation);
                },
                icon: const Icon(Icons.save))
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting
            ? null
            : (position) {
                setState(() {
                  _pickedLocation = position;
                });
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.placeLocation.lat,
            widget.placeLocation.lng,
          ),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.placeLocation.lat,
                        widget.placeLocation.lng,
                      ),
                ),
              }
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.placeLocation.lat,
                        widget.placeLocation.lng,
                      ),
                ),
              },
      ),
    );
  }
}
