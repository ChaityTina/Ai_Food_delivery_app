import 'package:flutter/material.dart';

class change_password_page extends StatefulWidget {
  const change_password_page({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<change_password_page> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleNewPassword() {
    setState(() {
      _obscureNew = !_obscureNew;
    });
  }

  void _toggleConfirmPassword() {
    setState(() {
      _obscureConfirm = !_obscureConfirm;
    });
  }

  void _verifyPassword() {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.length < 8) {
      _showMessage('Password must be at least 8 characters');
      return;
    }
    if (newPassword != confirmPassword) {
      _showMessage('Passwords do not match');
      return;
    }
    _showMessage('Password changed successfully');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.orange),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Reset Password',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Text(
              'Reset Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Your new password must be different from the previously used password',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 32),
            TextField(
              controller: _newPasswordController,
              obscureText: _obscureNew,
              decoration: InputDecoration(
                labelText: 'New Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNew ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _toggleNewPassword,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Must be at least 8 character',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirm,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _toggleConfirmPassword,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Both password must match',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifyPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Verify Account'),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
