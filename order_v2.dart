import 'package:flutter/material.dart';


class order_v2 extends StatelessWidget {
  const order_v2({super.key});

  static const kOrange = Color(0xFFFF8A00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CartItem(
                  title: "Burger With Meat",
                  price: 12230,
                  qty: 1,
                  imagePath: "lib/assets/Card1.png",
                ),
                _CartItem(
                  title: "Ordinary Burgers",
                  price: 12230,
                  qty: 2,
                  imagePath: "lib/assets/Card_ordinary.png",
                ),
                _CartItem(
                  title: "Ordinary Burgers",
                  price: 12230,
                  qty: 1,
                  imagePath: "lib/assets/Card_ordinary.png",
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Recommended For You",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87),
                    ),
                    Text("See All",
                        style: TextStyle(color: kOrange, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Expanded(
                        child: _RecommendationCard(
                            imagePath: 'lib/assets/Card1.png',
                            title: "Ordinary Burgers",
                            price: 17230)),
                    SizedBox(width: 12),
                    Expanded(
                        child: _RecommendationCard(
                            imagePath: 'lib/assets/Card_ordinary.png',
                            title: "Ordinary Burgers",
                            price: 17230)),
                  ],
                ),
                const SizedBox(height: 20),
                _PaymentSummary(
                  totalItems: 4,
                  subTotal: 48900,
                  deliveryFeeText: 'Free',
                  discount: 10900,
                  total: 38000,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kOrange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Order Now',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kOrange,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  final String title;
  final int price;
  final int qty;
  final String imagePath;

  const _CartItem(
      {required this.title,
        required this.price,
        required this.qty,
        required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Checkbox(
              value: true, onChanged: (val) {}, activeColor: _CartItem.kOrange),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath,
                width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text("\$ ${price.toString()}",
                    style: const TextStyle(
                        color: _CartItem.kOrange, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_circle_outline)),
              Text(qty.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
            ],
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete, color: Colors.red)),
        ],
      ),
    );
  }

  static const kOrange = Color(0xFFFF8A00);
}

class _RecommendationCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final int price;

  const _RecommendationCard(
      {required this.imagePath,
        required this.title,
        required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imagePath,
                  height: 100, width: double.infinity, fit: BoxFit.cover)),
          const SizedBox(height: 8),
          Text(title,
              style:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.star, size: 16, color: _CartItem.kOrange),
              SizedBox(width: 4),
              Text("4.9"),
              SizedBox(width: 12),
              Icon(Icons.location_on, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text("190m"),
            ],
          ),
          const SizedBox(height: 4),
          Text("\$ 17,230",
              style: const TextStyle(
                  color: _CartItem.kOrange, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _PaymentSummary extends StatelessWidget {
  final int totalItems;
  final int subTotal;
  final String deliveryFeeText;
  final int discount;
  final int total;

  const _PaymentSummary({
    required this.totalItems,
    required this.subTotal,
    required this.deliveryFeeText,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        children: [
          _row('Total Items ($totalItems)', "\$ $subTotal"),
          const SizedBox(height: 8),
          _row('Delivery Fee', deliveryFeeText,
              valueStyle: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          _row('Discount', "-\$ $discount",
              titleStyle: const TextStyle(color: Colors.red),
              valueStyle: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600)),
          const Divider(height: 24),
          _row('Total', "\$ $total",
              titleStyle: const TextStyle(fontWeight: FontWeight.w700),
              valueStyle: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Widget _row(String title, String value,
      {TextStyle? titleStyle, TextStyle? valueStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: titleStyle ??
                const TextStyle(color: Colors.black87, fontSize: 14)),
        Text(value,
            style: valueStyle ??
                const TextStyle(color: Colors.black87, fontSize: 14)),
      ],
    );
  }
}
