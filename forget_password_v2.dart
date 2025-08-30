import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ForgetPasswordV2(),
  ));
}

class ForgetPasswordV2 extends StatelessWidget {
  const ForgetPasswordV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/picture3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark overlay
          Container(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.5),
          ),

          // Main content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 5,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Select which contact details should we use to reset your password",
                    style: TextStyle(color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // WhatsApp Option
                  // WhatsApp Option using FontAwesome icon
                  const ResetOptionCard(
                    iconData: FontAwesomeIcons.whatsapp,
                    contactText: "+12 8347 2838 28",
                    selected: true,
                  ),

                  const SizedBox(height: 15),

                  // Email Option
                  const ResetOptionCard(
                    iconData: Icons.email_outlined,
                    contactText: "Albertstevano@gmail.com",
                    selected: false,
                  ),

                  const SizedBox(height: 30),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Navigate or do something
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResetOptionCard extends StatelessWidget {
  final IconData? iconData;
  final String? iconAsset;
  final String contactText;
  final bool selected;

  const ResetOptionCard({
    super.key,
    this.iconData,
    this.iconAsset,
    required this.contactText,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: selected ? Colors.orange : Colors.grey.shade300,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
        color: selected ? Colors.orange.shade50 : Colors.white,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: selected ? Colors.orange : Colors.grey.shade200,
            child: iconAsset != null
                ? Image.asset(iconAsset!, height: 20)
                : Icon(iconData, color: Colors.black),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              contactText,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          if (selected) const Icon(Icons.check_circle, color: Colors.orange)
        ],
      ),
    );
  }
}
