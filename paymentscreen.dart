import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'delivery.dart'; // ✅ Import DeliveryPage
import '../services/order_service.dart'; // Import DeliveryService

class paymentscreen extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final int totalPrice;

  const paymentscreen({
    super.key,
    required this.items,
    required this.totalPrice,
  });

  /// ✅ Place order + create delivery + navigate
  Future<void> _placeOrder(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in")),
      );
      return;
    }

    // 1️⃣ Save order
    final orderRef = await FirebaseFirestore.instance.collection("orders").add({
      "userId": user.uid,
      "foodItems": items,
      "totalPrice": totalPrice,
      "status": "pending",
      "createdAt": FieldValue.serverTimestamp(),
    });

    // 2️⃣ Create matching delivery using DeliveryService
    final deliveryService = DeliveryService();
    await deliveryService.createDelivery(orderRef.id, user.uid);

    // 3️⃣ Navigate to delivery tracking
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DeliveryPage(orderId: orderRef.id),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Payment'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Text(
              "You deserve better meal",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 20),

            const Text(
              "Item Ordered",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Show dynamic items
            ...items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item['image'],
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "৳ ${item['price']} x ${item['qty']} = ৳${item['price'] * item['qty']}",
                            style: const TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${item['qty']} items",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              );
            }).toList(),

            const SizedBox(height: 30),
            const Text(
              "Details Transaction",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            _buildTransactionRow("Total Price", "৳$totalPrice", isTotal: true),
            const Divider(height: 30, thickness: 1),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _placeOrder(context), // ✅ Now places order & opens DeliveryPage
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: const Text("Checkout Now",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _buildTransactionRow(String title, String amount,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            amount,
            style: TextStyle(
                color: isTotal ? Colors.deepOrange : Colors.black,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
