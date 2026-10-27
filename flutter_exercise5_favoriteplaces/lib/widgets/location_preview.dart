import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// OpenStreetMap tiles are free and need no API key, but their usage policy
// asks every app to identify itself with a user agent.
final osmTileLayer = TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'com.example.flutter_exercise5_favoriteplaces',
);

Marker locationMarker(LatLng point) {
  return Marker(
    point: point,
    width: 40,
    height: 40,
    alignment: Alignment.topCenter,
    child: const Icon(Icons.location_on, color: Colors.red, size: 40),
  );
}

// A small, non-interactive map with a marker — replaces the static map image.
class LocationPreview extends StatelessWidget {
  const LocationPreview({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    final point = LatLng(latitude, longitude);

    return FlutterMap(
      options: MapOptions(
        initialCenter: point,
        initialZoom: 16,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.none,
        ),
      ),
      children: [
        osmTileLayer,
        MarkerLayer(markers: [locationMarker(point)]),
      ],
    );
  }
}
