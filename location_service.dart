import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Ask for location permission
  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  /// Start tracking rider's live location and update Firestore
  Future<void> startRiderTracking(String orderId, String riderId) async {
    bool granted = await requestPermission();
    if (!granted) return;

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // update every 10 meters
      ),
    ).listen((Position position) async {
      await _db.collection("deliveries").doc(orderId).update({
        "riderId": riderId,
        "riderLocation": GeoPoint(position.latitude, position.longitude),
        "status": "on_the_way", // optional: update status
        "updatedAt": FieldValue.serverTimestamp(),
      });
    });
  }
}
