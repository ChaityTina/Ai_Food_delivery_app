import 'package:flutter/material.dart';

class menu_v2 extends StatelessWidget {
  const menu_v2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BurgerDetailsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BurgerDetailsPage extends StatefulWidget {
  const BurgerDetailsPage({super.key});

  @override
  State<BurgerDetailsPage> createState() => _BurgerDetailsPageState();
}

class _BurgerDetailsPageState extends State<BurgerDetailsPage> {
  int quantity = 2;
  int pricePerItem = 12230;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.asset(
                  'assets/images/burger_1.jpg',
                  width: double.infinity,
                  height: 320,
                  fit: BoxFit.cover,
                ),
              ),
              // Back icon
              Positioned(
                top: 50,
                left: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              // Heart icon
              Positioned(
                top: 50,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.favorite_border),
                ),
              ),
              // Center title
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "About This Menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black38,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // Rectangle Indicators
              const Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IndicatorDot(color: Colors.grey),
                    SizedBox(width: 6),
                    IndicatorDot(color: Colors.amber),
                    SizedBox(width: 6),
                    IndicatorDot(color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Title & Price
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Burger With Meat 🍔",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$ 12,230",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Delivery Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: const [
                Icon(Icons.local_shipping, color: Colors.orange, size: 20),
                SizedBox(width: 4),
                Text("Free Delivery"),
                SizedBox(width: 16),
                Icon(Icons.schedule, color: Colors.orange, size: 20),
                SizedBox(width: 4),
                Text("20 - 30"),
                SizedBox(width: 16),
                Icon(Icons.star, color: Colors.orange, size: 20),
                SizedBox(width: 4),
                Text("4.5"),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Description title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Description text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              "Burger With Meat is a typical food from our restaurant that is much in demand by many people, this is very recommended for you.",
              style: TextStyle(color: Colors.black54),
            ),
          ),

          const Spacer(),

          // Quantity & total price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() => quantity--);
                    }
                  },
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.black),
                ),
                Text('$quantity', style: const TextStyle(fontSize: 20)),
                IconButton(
                  onPressed: () => setState(() => quantity++),
                  icon: const Icon(Icons.add_circle_outline, color: Colors.black),
                ),
                const Spacer(),
                Text(
                  '\$ ${(pricePerItem * quantity).toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          // Add to Cart Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart,color: Colors.white,),
                label: const Text("Add to Cart", style: TextStyle(fontSize: 18,color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Rectangle indicator widget
class IndicatorDot extends StatelessWidget {
  final Color color;
  const IndicatorDot({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
