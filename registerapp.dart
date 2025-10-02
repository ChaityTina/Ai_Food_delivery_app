import 'package:flutter/material.dart';

class registerapp extends StatefulWidget {
  const registerapp({super.key});

  @override
  State<registerapp> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<registerapp> {
  bool _obscureText = true;
  bool _agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Create your new account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Create an account to start looking for the food you like",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email Address",
                  border: OutlineInputBorder(),
                  hintText: "Albertstevano@gmail.com",
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "User Name",
                  border: OutlineInputBorder(),
                  hintText: "Alber tstevano",
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agreeTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _agreeTerms = value ?? false;
                      });
                    },
                    activeColor: Colors.orange,
                  ),
                  const Flexible(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "I Agree with "),
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(color: Colors.orange),
                          ),
                          TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
                  onPressed: _agreeTerms ? () {} : null,
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Or sign in with"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  NetworkCircleIcon(
                      url: "https://img.icons8.com/color/48/google-logo.png"),
                  SizedBox(width: 15),
                  NetworkCircleIcon(
                      url: "https://img.icons8.com/color/48/facebook-new.png"),
                  SizedBox(width: 15),
                  NetworkCircleIcon(
                      url:
                      "https://img.icons8.com/ios-filled/50/000000/mac-os.png"),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      // Navigate to sign in
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NetworkCircleIcon extends StatelessWidget {
  final String url;

  const NetworkCircleIcon({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey.shade200,
      child: ClipOval(
        child: Image.network(
          url,
          height: 24,
          width: 24,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.error, size: 20, color: Colors.red),
        ),
      ),
    );
  }
}
