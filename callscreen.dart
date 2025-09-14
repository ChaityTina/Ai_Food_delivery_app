import 'dart:async';
import 'package:flutter/material.dart';

class callscreen extends StatefulWidget {
  final String userName;
  final String userAvatar;

  const callscreen({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<callscreen> createState() => _callscreenState();
}

class _callscreenState extends State<callscreen> {
  int _seconds = 0;
  late Timer _timer;

  String get _formattedTime {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
                const Spacer(),

                // Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(widget.userAvatar),
                ),

                const SizedBox(height: 16),

                // Name
                Text(
                  widget.userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                // Call Duration
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.fiber_manual_record,
                              size: 10, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            _formattedTime,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
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
                      _buildCircleButton(Icons.call_end, Colors.red,
                          iconColor: Colors.white,
                          isBig: true,
                          onTap: () {
                            Navigator.pop(context); // End call
                          }),
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

  Widget _buildCircleButton(IconData icon, Color bgColor,
      {Color iconColor = Colors.white, bool isBig = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isBig ? 70 : 55,
        height: isBig ? 70 : 55,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: isBig ? 30 : 24),
      ),
    );
  }
}
