import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/location_preview.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    // Default map position: NTNU Gløshaugen, Trondheim.
    this.location = const PlaceLocation(
      latitude: 63.4195,
      longitude: 10.4021,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    final markerPosition = _pickedLocation ??
        (widget.isSelecting
            ? null
            : LatLng(widget.location.latitude, widget.location.longitude));

    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.isSelecting ? 'Pick your Location' : 'Your Location'),
          actions: [
            if (widget.isSelecting)
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  Navigator.of(context).pop(_pickedLocation);
                },
              ),
          ]),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          initialZoom: 16,
          onTap: !widget.isSelecting
              ? null
              : (tapPosition, position) {
                  setState(() {
                    _pickedLocation = position;
                  });
                },
        ),
        children: [
          osmTileLayer,
          if (markerPosition != null)
            MarkerLayer(markers: [locationMarker(markerPosition)]),
          const SimpleAttributionWidget(
            source: Text('OpenStreetMap contributors'),
          ),
        ],
      ),
    );
  }
}
