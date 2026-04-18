import 'dart:async';
import 'package:geolocator/geolocator.dart';

String locationMessage = "";

StreamSubscription<Position>? positionStream;

Future<void> getLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    locationMessage = "GPS isn't enabled";
    return;
  }

  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    locationMessage = "Permission permanently denied";
    return;
  }

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  locationMessage =
  "Lat: ${position.latitude}\n  Lng: ${position.longitude}";
}

Future<double> calculateDistance({
  required double targetLat,
  required double targetLong,
}) async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  return Geolocator.distanceBetween(
    position.latitude,
    position.longitude,
    targetLat,
    targetLong,
  );
}

Stream<Position> getLocationStream() {
  return Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    ),
  );
}


void startTracking(Function(Position) onUpdate) {
  positionStream?.cancel();
  positionStream = getLocationStream().listen((position) {
    onUpdate(position);
  });
}

void stopTracking() {
  positionStream?.cancel();
  positionStream = null;
}