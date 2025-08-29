import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgetPasswordPage(),
    );
  }
}

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const TopStatusBar(),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      "Forgot password?",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Enter your email address and we'll send you\nconfirmation code to reset your password",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "Email Address",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Albertstevano@gmail.com',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const CustomSamsungKeyboard(),
          ],
        ),
      ),
    );
  }
}

class TopStatusBar extends StatelessWidget {
  const TopStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("9:41",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: const [
              Icon(Icons.signal_cellular_alt, size: 18),
              SizedBox(width: 4),
              Icon(Icons.wifi, size: 18),
              SizedBox(width: 4),
              Icon(Icons.battery_full, size: 20),
            ],
          )
        ],
      ),
    );
  }
}

class CustomSamsungKeyboard extends StatelessWidget {
  const CustomSamsungKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    final keysRow1 = ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
    final keysRow2 = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
    final keysRow3 = ['⬆', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '⌫'];
    final keysRow4 = ['123', '🌐', 'space', '↩'];

    Widget buildKey(String label, {double flex = 1}) {
      return Expanded(
        flex: label == 'space' ? 4 : flex.toInt(),
        child: Container(
          margin: const EdgeInsets.all(4),
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFE5E5E5),
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: keysRow1.map((k) => buildKey(k)).toList()),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: keysRow2.map((k) => buildKey(k)).toList(),
          ),
          const SizedBox(height: 4),
          Row(children: keysRow3.map((k) => buildKey(k)).toList()),
          const SizedBox(height: 4),
          Row(
            children: keysRow4.map((k) {
              double flex = k == 'space' ? 4 : 1;
              return buildKey(k, flex: flex);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
