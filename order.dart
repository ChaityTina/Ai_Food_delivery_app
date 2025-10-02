import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bottom_navigation.dart';
import 'paymentscreen.dart'; 

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  static const kOrange = Color(0xFFFF8A00);
  static const kBg = Color(0xFFFFF6FA);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Please login first")),
      );
    }

    final cartRef =
        FirebaseFirestore.instance.collection("carts").doc(user.uid).collection("items");

    return StreamBuilder<QuerySnapshot>(
      stream: cartRef.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final items = snapshot.data!.docs.map((doc) {
          return {
            "id": doc.id,
            "name": doc['name'],
            "price": doc['price'],
            "qty": doc['qty'],
            "image": doc['image'],
          };
        }).toList();

        int totalItems = items.fold<int>(0, (prev, item) => prev + (item['qty'] as int));

        return Scaffold(
          appBar: AppBar(
            title: const Text("My Cart"),
            centerTitle: true,
            backgroundColor: kBg,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavigation(), // your class in bottom_navigation.dart
                  ),
                );
              },
            ),
            actions: [
              if (totalItems > 0)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.shopping_cart, color: Colors.black),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                            child: Text(
                              '$totalItems',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          backgroundColor: kBg,
          body: items.isEmpty
              ? _emptyCartView(context)
              : _cartListView(items, cartRef, user),
        );
      },
    );
  }

  Widget _emptyCartView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Illustration.png',
            height: 220,
            width: 220,
          ),
          const SizedBox(height: 20),
          const Text(
            "Ouch! Hungry",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 8),
          const Text(
            "Seems like you have not ordered\nany food yet",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BottomNavigation()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            ),
            child: const Text(
              "Find Foods",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartListView(List<Map<String, dynamic>> items,
      CollectionReference<Map<String, dynamic>> cartRef, User user) {
    int subTotal = items.fold<int>(0, (prev, item) {
      return prev + (item['price'] as int) * (item['qty'] as int);
    });

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final itemTotal = (item['price'] as int) * (item['qty'] as int);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Image.network(item['image'], width: 60, height: 60, fit: BoxFit.cover),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['name'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(
                              "Price: ৳${item['price']} x ${item['qty']} = ৳$itemTotal",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              if ((item['qty'] as int) > 1) {
                                await cartRef
                                    .doc(item['id'])
                                    .update({'qty': (item['qty'] as int) - 1});
                              }
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text("${item['qty']}", style: const TextStyle(fontSize: 16)),
                          IconButton(
                            onPressed: () async {
                              await cartRef
                                  .doc(item['id'])
                                  .update({'qty': (item['qty'] as int) + 1});
                            },
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () async {
                          await cartRef.doc(item['id']).delete();
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Card(
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _summaryRow("Subtotal", "৳$subTotal",
                isBold: true, color: kOrange),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("orders").add({
                  "userId": user.uid,
                  "foodItems": items,
                  "totalPrice": subTotal,
                  "status": "pending",
                  "createdAt": FieldValue.serverTimestamp(),
                });

                for (var item in items) {
                  await cartRef.doc(item['id']).delete();
                }

                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => paymentscreen(
                              items: items,
                              totalPrice: subTotal,
                            )),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kOrange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text("Order Now",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
        )
      ],
    );
  }

  Widget _summaryRow(String label, String value,
      {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: color)),
        ],
      ),
    );
  }
}
