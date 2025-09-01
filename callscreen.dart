import 'package:flutter/material.dart';

class callscreen extends StatelessWidget {
  const callscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Stack(
          children: [
            // Background gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black54,
                    Colors.black87,
                  ],
                ),
              ),
            ),

            // Call Info & Buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                const Spacer(),

                // Name
                const Text(
                  "Stevano Clirover",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                // Call Duration
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.fiber_manual_record, size: 10, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            "03:45",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Control Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCircleButton(Icons.volume_up, Colors.grey.shade800),
                      _buildCircleButton(Icons.call_end, Colors.red, iconColor: Colors.white, isBig: true),
                      _buildCircleButton(Icons.mic_off, Colors.grey.shade800),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, Color bgColor, {Color iconColor = Colors.white, bool isBig = false}) {
    return Container(
      width: isBig ? 70 : 55,
      height: isBig ? 70 : 55,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: isBig ? 30 : 24),
    );
  }
}
