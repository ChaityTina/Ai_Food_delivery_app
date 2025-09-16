import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class menu_v1 extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String price;

  const menu_v1({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  @override
  State<menu_v1> createState() => _MenuDetailsPageState();
}

class _MenuDetailsPageState extends State<menu_v1> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                widget.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 20,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(widget.price,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoCard(Icons.local_shipping, "Free Delivery"),
                        _infoCard(Icons.timer, "20-30 min"),
                        _infoCard(Icons.star, "4.8"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Description",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Delicious food prepared with fresh ingredients. Highly recommended!",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (quantity > 1) setState(() => quantity--);
                      },
                      icon: Icon(Icons.remove_circle_outline,
                          color: Colors.grey[600]),
                    ),
                    Text(quantity.toString(),
                        style: const TextStyle(fontSize: 18)),
                    IconButton(
                      onPressed: () => setState(() => quantity++),
                      icon: Icon(Icons.add_circle_outline,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please login first")));
                        return;
                      }

                      final cartRef = FirebaseFirestore.instance
                          .collection("carts")
                          .doc(user.uid)
                          .collection("items");

                      // Print for debugging
                      print("User: ${user.uid}");
                      print("Adding ${widget.name} x $quantity");

                      final query = await cartRef
                          .where('name', isEqualTo: widget.name)
                          .get();

                      if (query.docs.isNotEmpty) {
                        final doc = query.docs.first;
                        await cartRef
                            .doc(doc.id)
                            .update({'qty': (doc['qty'] as int) + quantity});
                        print("Updated quantity in cart");
                      } else {
                        await cartRef.add({
                          'name': widget.name,
                          'price': int.parse(widget.price
                              .replaceAll(RegExp(r'[^0-9]'), '')),
                          'qty': quantity,
                          'image': widget.imageUrl,
                        });
                        print("Added new item to cart");
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to Cart")));
                      setState(() => quantity = 1);
                    } catch (e) {
                      print("Error adding to cart: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: $e")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  label: const Text("Add to Cart",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _infoCard(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.orange),
          const SizedBox(width: 4),
          Text(text)
        ],
      ),
    );
  }
}
