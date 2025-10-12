import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class DeliveryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createDelivery(String orderId, String userId) async {
    // Get order details
    final orderSnap = await _db.collection("orders").doc(orderId).get();
    if (!orderSnap.exists) return;

    final orderData = orderSnap.data() as Map<String, dynamic>;
    int orderPrice = orderData["totalPrice"] ?? 0;

    // Rider fee (random)
    final riderFeeOptions = [60, 90, 100, 150];
    final riderFee = riderFeeOptions[DateTime.now().millisecondsSinceEpoch % 4];

    // ✅ Request permission + fetch device location
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      throw Exception("Location permissions are denied");
    }

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Save delivery doc with real user GPS
    await _db.collection("deliveries").doc(orderId).set({
      "userId": userId,
      "status": "pending",
      "restaurantLocation": const GeoPoint(22.3620, 91.7900), // Chittagong
      "userLocation": const GeoPoint(22.3569, 91.7832), // ✅ From GPS
      "riderLocation": const GeoPoint(22.3600, 91.7800), // Rider start
      "orderPrice": orderPrice,
      "riderFee": riderFee,
      "totalPrice": orderPrice + riderFee,
      "createdAt": FieldValue.serverTimestamp(),
      "deliveryTime": FieldValue.serverTimestamp(),
    });
  }
}
