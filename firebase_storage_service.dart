import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  final _storage = FirebaseStorage.instance;
  final _db = FirebaseFirestore.instance;

  Future<File?> pickImageFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 85);
    return picked == null ? null : File(picked.path);
  }

  Future<String> _uploadFileToPath(File file, String path) async {
    final ref = _storage.ref().child(path);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  /// Creates a doc id first, uploads to /foods/{id}.jpg, then writes Firestore.
  Future<void> createFoodWithImage({
    required File imageFile,
    required String name,
    required double price,
    required String description,
    required String category,
  }) async {
    final docRef = _db.collection('foods').doc(); // generate id
    final foodId = docRef.id;

    final imageUrl = await _uploadFileToPath(imageFile, 'foods/$foodId.jpg');

    await docRef.set({
      'name': name.trim(),
      'price': price,
      'description': description.trim(),
      'category': category,
      'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'active': true,
    });
  }
}
