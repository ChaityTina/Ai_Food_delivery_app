import 'package:ai_food_delivery_app/screens/search_v3.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/notifications.dart';
import 'menu_v1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class home_v1 extends StatefulWidget {
  const home_v1({super.key});

  @override
  State<home_v1> createState() => _HomeV1State();
}

class _HomeV1State extends State<home_v1> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _saveUserLocation();
  }

  Future<void> _saveUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) return;

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (user != null) {
        await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
          "location": {"lat": pos.latitude, "lng": pos.longitude}
        }, SetOptions(merge: true));
      }
    } catch (e) {
      debugPrint("❌ Location error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, 
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
        
              Stack(
                children: [
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/food_banner_cut2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 240,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Your Location",
                                    style: TextStyle(color: Colors.white, fontSize: 14)),
                                Icon(Icons.keyboard_arrow_down,
                                    color: Colors.white, size: 18),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, color: Colors.white, size: 16),
                                    SizedBox(width: 5),
                                    Text("Detecting...",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SearchV3()),
                                );
                              },
                              child: const CircleIcon(icon: Icons.search),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const notifications()),
                                );
                              },
                              child: const CircleIcon(icon: Icons.notifications_none),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text(
                          "Provide the best\nfood for you",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Find by Category",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("See All", style: TextStyle(color: Colors.deepOrange)),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CategoryItem(title: 'Burger', icon: Icons.lunch_dining, isActive: true),
                    CategoryItem(title: 'Taco', icon: Icons.fastfood),
                    CategoryItem(title: 'Drink', icon: Icons.local_drink),
                    CategoryItem(title: 'Pizza', icon: Icons.local_pizza),
                  ],
                ),
              ),

              const SizedBox(height: 10),

            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("foods")
                      .where("category", whereIn: ["Burger", "Pizza", "Tacos", "Drinks"])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final foods = snapshot.data!.docs;

                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        var food = foods[index].data() as Map<String, dynamic>;
                        final price =
                            food["price"] != null ? food["price"].toString() : "0";

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => menu_v1(
                                  name: food["name"] ?? "Unknown",
                                  imageUrl: food["imageUrl"] ?? "",
                                  price: "Tk $price",
                                ),
                              ),
                            );
                          },
                          child: FoodCard(
                            imageUrl: food["imageUrl"] ?? "",
                            title: food["name"] ?? "Unknown",
                            price: "Tk $price",
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleIcon extends StatelessWidget {
  final IconData icon;
  const CircleIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3), shape: BoxShape.circle),
      child: Center(child: Icon(icon, color: Colors.white, size: 20)),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  const CategoryItem(
      {super.key, required this.title, required this.icon, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive ? Colors.deepOrange : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? Colors.white : Colors.black),
          const SizedBox(height: 4),
          Text(title,
              style: TextStyle(
                  fontSize: 12,
                  color: isActive ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class FoodCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;

  const FoodCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard>
    with SingleTickerProviderStateMixin {
  bool isLiked = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.8,
      upperBound: 1.2,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onLikeTap() async {
    if (!isLiked) {
      await _controller.forward();
      await _controller.reverse();
    }
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  widget.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: GestureDetector(
                  onTap: _onLikeTap,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16,
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text("4.9"),
                    SizedBox(width: 8),
                    Icon(Icons.location_on, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text("190m"),
                  ],
                ),
                const SizedBox(height: 5),
                Text(widget.price,
                    style: const TextStyle(
                        color: Colors.deepOrange, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
