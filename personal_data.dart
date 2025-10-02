import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../services/upload_service.dart'; // ✅ use UploadService for users

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  final user = FirebaseAuth.instance.currentUser;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? gender;
  String? _uploadedImageUrl;
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (user == null) return;
    var doc = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
    if (doc.exists) {
      var data = doc.data()!;
      setState(() {
        nameController.text = data['name'] ?? '';
        dobController.text = data['dob'] ?? '';
        phoneController.text = data['phone'] ?? '';
        emailController.text = data['email'] ?? user!.email ?? '';
        gender = data['gender'];
        _uploadedImageUrl = data['imageUrl'];
      });
    }
  }
  Future<void> pickAndUploadImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null) return;

    setState(() => _uploading = true);
    final file = File(picked.path);

    // ✅ Upload using UploadService
    final url = await UploadService.uploadUserImage(file);
    if (url != null && user != null) {
      await FirebaseFirestore.instance.collection("users").doc(user!.uid).set(
        {"imageUrl": url},
        SetOptions(merge: true),
      );
      setState(() => _uploadedImageUrl = url);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Profile picture updated")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Upload failed")),
      );
    }
    setState(() => _uploading = false);
  }

  Future<void> saveUserData() async {
    if (user == null) return;
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
      "name": nameController.text,
      "dob": dobController.text,
      "gender": gender,
      "phone": phoneController.text,
      "email": emailController.text,
      "imageUrl": _uploadedImageUrl,
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile saved successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Data'), backgroundColor: Colors.orange),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _uploadedImageUrl != null
                      ? NetworkImage(_uploadedImageUrl!)
                      : const AssetImage('assets/images/user_3.png') as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: pickAndUploadImage,
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: Icon(Icons.camera_alt, color: Colors.orange, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            if (_uploading)
              const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(color: Colors.orange),
              ),
            const SizedBox(height: 20),

            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Full Name")),
            const SizedBox(height: 10),
            TextField(controller: dobController, decoration: const InputDecoration(labelText: "Date of Birth")),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: gender,
              items: ["Male", "Female", "Other"].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
              onChanged: (val) => setState(() => gender = val),
              decoration: const InputDecoration(labelText: "Gender"),
            ),
            const SizedBox(height: 10),
            TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Phone")),
            const SizedBox(height: 10),
            TextField(controller: emailController, readOnly: true, decoration: const InputDecoration(labelText: "Email")),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveUserData,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, minimumSize: const Size.fromHeight(50)),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}