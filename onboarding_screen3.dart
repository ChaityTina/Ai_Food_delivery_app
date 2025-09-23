import 'package:flutter/material.dart';
import 'onboarding_screen2.dart'; // Import the second onboarding screen


class onboarding_screen3 extends StatelessWidget {
  const onboarding_screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/picture2.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              colorBlendMode: BlendMode.darken,
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          const Positioned(
            top: 40,
            left: 20,
            child: Text('9:41', style: TextStyle(color: Colors.white)),
          ),
          const Positioned(
            top: 40,
            right: 20,
            child: Row(
              children: [
                Icon(
                  Icons.signal_cellular_4_bar,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 4),
                Icon(Icons.wifi, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Icon(Icons.battery_full, color: Colors.white, size: 16),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(40),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'We serve\nincomparable\ndelicacies',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'All the best restaurants with their top\nmenu waiting for you, they can’t wait\nfor your order!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 12,
                        height: 4,
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 12,
                        height: 4,
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 20,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      // Replace with the desired navigation or action
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.orange,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const onboarding_screen2()),
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
