import 'package:flutter/material.dart';

class menu_v3 extends StatelessWidget {
  const menu_v3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar & Image with indicators
            Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _circleIcon(Icons.arrow_back_ios_new),
                          const Text(
                            "About This Menu",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          _circleIcon(Icons.share_outlined),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/burger_1.jpg',
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Removed bottom margin here
                    const SizedBox(height: 12),
                    // Page indicator - directly below image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _indicator(active: true),
                        const SizedBox(width: 6),
                        _indicator(active: false),
                        const SizedBox(width: 6),
                        _indicator(active: false),
                      ],
                    ),
                  ],
                ),
                const Positioned(
                  top: 65,
                  right: 30,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite, color: Colors.red), // Solid red heart
                  ),
                ),
              ],
            ),

            // Title, Price & Info Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Burger With Meat 🍔',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$12,230',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Icon(Icons.local_shipping, size: 18, color: Colors.orange),
                      SizedBox(width: 4),
                      Text("Free Delivery"),
                      SizedBox(width: 20),
                      Icon(Icons.timer_outlined, size: 18, color: Colors.orange),
                      SizedBox(width: 4),
                      Text("20 - 30"),
                      SizedBox(width: 20),
                      Icon(Icons.star, size: 18, color: Colors.orange),
                      SizedBox(width: 4),
                      Text("4.5"),
                    ],
                  ),
                ],
              ),
            ),

            // Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Burger With Meat is a typical food from our restaurant that is much in demand by many people, this is very recommended for you.",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),

            // Removed the divider line above -+ buttons

            // Recommended + See All
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Recommended For You",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(fontSize: 14, color: Colors.orange),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Bottom Bar
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        _iconCircle(Icons.remove),
                        const SizedBox(width: 8),
                        const Text("4", style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        _iconCircle(Icons.add),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                      label: const Text(
                        "Add to Cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Top bar icons with circular white background
  Widget _circleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18),
    );
  }

  // Circular button for - and + with white background
  Widget _iconCircle(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.orange, size: 20),
    );
  }

  // Rectangular page indicator
  Widget _indicator({required bool active}) {
    return Container(
      width: 22,
      height: 6,
      decoration: BoxDecoration(
        color: active ? Colors.orange : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
