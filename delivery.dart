import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryPage extends StatelessWidget {
  final String orderId;
  const DeliveryPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Tracking"),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("deliveries")
            .doc(orderId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          // ✅ Locations (GeoPoints)
          final userGeo = data["userLocation"] as GeoPoint;
          final restGeo = data["restaurantLocation"] as GeoPoint;
          final riderGeo = data["riderLocation"] as GeoPoint;

          final userLoc = LatLng(userGeo.latitude, userGeo.longitude);
          final restLoc = LatLng(restGeo.latitude, restGeo.longitude);
          final riderLoc = LatLng(riderGeo.latitude, riderGeo.longitude);

          // ✅ Delivery values
          int riderFee = data["riderFee"] ?? 0;
          int orderPrice = data["orderPrice"] ?? 0;
          int totalPrice = orderPrice + riderFee;

          // ✅ Delivery time (auto created if not set)
          Timestamp? deliveryTime = data["deliveryTime"];
          if (deliveryTime == null) {
            deliveryTime = Timestamp.now();

            // Update DB only once
            FirebaseFirestore.instance
                .collection("deliveries")
                .doc(orderId)
                .update({
              "deliveryTime": deliveryTime,
              "riderFee": riderFee == 0
                  ? [60, 90, 100, 150][Random().nextInt(4)]
                  : riderFee,
            });
          }

          return Column(
            children: [
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: userLoc,
                    initialZoom: 14,
                  ),
                  children: [
                    // Tiles
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: "com.yourapp.fooddelivery",
                    ),

                    // Markers
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: riderLoc,
                          width: 60,
                          height: 60,
                          child: const Icon(Icons.delivery_dining,
                              color: Colors.orange, size: 40),
                        ),
                        Marker(
                          point: userLoc,
                          width: 60,
                          height: 60,
                          child: const Icon(Icons.location_pin,
                              color: Colors.red, size: 40),
                        ),
                        Marker(
                          point: restLoc,
                          width: 60,
                          height: 60,
                          child: const Icon(Icons.restaurant,
                              color: Colors.green, size: 40),
                        ),
                      ],
                    ),

                    // Polyline
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: [restLoc, riderLoc, userLoc],
                          color: Colors.orange,
                          strokeWidth: 4.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ✅ Price + Delivery Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, -2))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Price: Tk $orderPrice",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Text("Rider Fee: Tk $riderFee",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Divider(),
                    Text("Total: Tk $totalPrice",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange)),
                    const SizedBox(height: 6),
                    Text("Delivery Time: ${deliveryTime.toDate()}",
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
