import 'dart:ui';
import 'package:ai_food_delivery_app/screens/extraCard.dart';
import 'package:ai_food_delivery_app/screens/help_center.dart';
import 'package:ai_food_delivery_app/screens/personal_data.dart';
import 'package:ai_food_delivery_app/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginfield.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _ProfileState();
}

class _ProfileState extends State<profile> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool showAllOrders = false; // ✅ toggle to show all orders

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(body: Center(child: Text("No user logged in")));
    }

    final DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(user!.uid);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Profile Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 30),

                // ✅ Profile picture
                StreamBuilder<DocumentSnapshot>(
                  stream: userRef.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : const AssetImage('assets/images/user_3.png')
                                as ImageProvider,
                      );
                    }
                    final data = snapshot.data!.data() as Map<String, dynamic>;
                    String? imageUrl = data['imageUrl'];
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                          ? NetworkImage(imageUrl)
                          : const AssetImage('assets/images/user_3.png')
                              as ImageProvider,
                    );
                  },
                ),

                const SizedBox(height: 20),

                // ✅ Name + Email
                StreamBuilder<DocumentSnapshot>(
                  stream: userRef.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Column(
                        children: [
                          Text(
                            user!.displayName ?? "No Name",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user!.email ?? "No Email",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      );
                    }

                    final data = snapshot.data!.data() as Map<String, dynamic>;
                    String name =
                        data['name'] ?? user!.displayName ?? "No Name";
                    String email = data['email'] ?? user!.email ?? "No Email";

                    return Column(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),

                // ✅ Orders Section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "My Orders",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showAllOrders = !showAllOrders;
                              });
                            },
                            child: Text(
                              showAllOrders ? "Show Less" : "See All",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFE8C00),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ✅ Orders from Firestore
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("orders")
                            .where("userId", isEqualTo: user!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Padding(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator(),
                            );
                          }
                          final orders = snapshot.data!.docs;
                          if (orders.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.all(20),
                              child: Text("No orders found"),
                            );
                          }

                          int orderCount = showAllOrders
                              ? (orders.length < 3 ? orders.length : 3)
                              : 1;

                          return Column(
                            children: List.generate(orderCount, (index) {
                              final orderData =
                                  orders[index].data() as Map<String, dynamic>;

                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Order ID ${orders[index].id}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          orderData['status'] ?? "Unknown",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFFE8C00),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      indent: 1,
                                      endIndent: 1,
                                    ),
                                    Row(
                                      children: [
                                        if (orderData['foodItems'] != null &&
                                            orderData['foodItems'].isNotEmpty)
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              orderData['foodItems'][0]
                                                      ['image'] ??
                                                  "",
                                              height: 70,
                                              width: 70,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                'assets/images/burger_1.jpg',
                                                height: 70,
                                                width: 70,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                orderData['foodItems'] != null &&
                                                        orderData['foodItems']
                                                            .isNotEmpty
                                                    ? orderData['foodItems'][0]
                                                            ['name'] ??
                                                        "Food Item"
                                                    : "Food Item",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "\$ ${orderData['totalPrice'] ?? 0}",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFFE8C00),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "${orderData['foodItems']?.length ?? 0} items",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                const Divider(thickness: 2, indent: 20, endIndent: 20),

                // ✅ Profile Options
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text("Personal Data"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalData(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text("Settings"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const settings(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.credit_card_outlined),
                  title: const Text("Extra Card"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const extraCard(),
                      ),
                    );
                  },
                ),
                const Divider(thickness: 1, indent: 16, endIndent: 16),

                // ✅ Support Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Support",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text("Help Center"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const help_center(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete_outline),
                  title: const Text("Request Account Deletion"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text("Add another account"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),

                // ✅ Sign Out
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showSignOutDialog(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.grey),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    icon: const Icon(Icons.logout, color: Colors.red),
                    label: const Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text("Sign Out"),
            content: const Text(
              "Are you sure you want to sign out of your account?",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cancel
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginField()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
