import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class NetourismLocation {
  static Future<LatLng> getLocation() async {
    Position? position;
    if (await _checkLocationPermission()) {
      // Permission granted, get location

      position = await _getCurrentLocation();
    } else {
      // Request permission
      await _requestLocationPermission();
    }
    return LatLng(position!.latitude, position.longitude);
  }

  static Future<bool> _checkLocationPermission() async {
    return await Permission.location.isGranted;
  }

  static Future<void> _requestLocationPermission() async {
    await Permission.location.request();
  }

  static Future<Position> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Use the position data (e.g., position.latitude, position.longitude)
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    return position;
  }
}

late LatLng curentLocation;
