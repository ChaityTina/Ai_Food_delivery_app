import 'package:flutter/material.dart';


class otp_field extends StatefulWidget {
  const otp_field({super.key});

  @override
  State<otp_field> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<otp_field> {
  List<String> otp = ['', '', '', ''];

  void _setDigit(String digit) {
    for (int i = 0; i < otp.length; i++) {
      if (otp[i].isEmpty) {
        setState(() {
          otp[i] = digit;
        });
        break;
      }
    }
  }

  void _deleteDigit() {
    for (int i = otp.length - 1; i >= 0; i--) {
      if (otp[i].isNotEmpty) {
        setState(() {
          otp[i] = '';
        });
        break;
      }
    }
  }

  Widget _otpBox(String value) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _keyboardButton({String? label, IconData? icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 60,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: icon != null
            ? Icon(icon, size: 26)
            : Text(
          label!,
          style:
          const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildCustomKeyboard() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _keyboardButton(label: '1', onTap: () => _setDigit('1')),
            _keyboardButton(label: '2', onTap: () => _setDigit('2')),
            _keyboardButton(label: '3', onTap: () => _setDigit('3')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _keyboardButton(label: '4', onTap: () => _setDigit('4')),
            _keyboardButton(label: '5', onTap: () => _setDigit('5')),
            _keyboardButton(label: '6', onTap: () => _setDigit('6')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _keyboardButton(label: '7', onTap: () => _setDigit('7')),
            _keyboardButton(label: '8', onTap: () => _setDigit('8')),
            _keyboardButton(label: '9', onTap: () => _setDigit('9')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 70, height: 60), // Empty space
            _keyboardButton(label: '0', onTap: () => _setDigit('0')),
            _keyboardButton(
                icon: Icons.backspace_outlined, onTap: _deleteDigit),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButton(),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'OTP',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Email verification',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Enter the verification code we send you on:\nAlberts*****@gmail.com',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: otp.map((e) => _otpBox(e)).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Text("Didn't receive code? "),
                    Text(
                      "Resend",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(Icons.watch_later_outlined, size: 16),
                    SizedBox(width: 6),
                    Text("09.00", style: TextStyle(color: Colors.black87)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Add OTP verification logic here
                      print("Entered OTP: ${otp.join()}");
                    },
                    child: const Text("Continue"),
                  ),
                ),
                const SizedBox(height: 20),
                _buildCustomKeyboard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
