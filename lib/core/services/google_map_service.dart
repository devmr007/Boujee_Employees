import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapService {
  /// Provided Google Maps API Key
  static const String apiKey = 'AIzaSyAy21Igr3AC32s45TcLiQLAYnt0BSlqiyA';

  /// Check and request location permission from the device
  static Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// Get current user location coordinates
  static Future<Position?> getCurrentLocation() async {
    try {
      bool hasPermission = await requestLocationPermission();
      if (hasPermission) {
        return await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error obtaining location: $e');
    }
    return null;
  }

  /// Convert coordinates to a readable address
  static Future<String> getAddressFromCoordinates(
    double lat,
    double lng,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      }
    } catch (e) {
      debugPrint('Error getting address: $e');
    }
    return "Unknown Address";
  }

  /// Generate a smooth route polyline connecting provider and customer
  static Polyline createRoutePolyline({
    required String polylineId,
    required List<LatLng> points,
    Color color = const Color(0xFFE58A00),
  }) {
    return Polyline(
      polylineId: PolylineId(polylineId),
      points: points,
      color: color,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      jointType: JointType.round,
    );
  }
}
