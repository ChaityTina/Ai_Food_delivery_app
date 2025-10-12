import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';

class CloudinaryService {
  static final _cloudinary = CloudinaryPublic(
    'dosz3fmol',   // your Cloud name
    'foodsapp',    // unsigned upload preset for foods
    cache: false,
  );

  static Future<String?> uploadFoodImage(File file) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      return response.secureUrl; // ✅ Food image URL
    } catch (e) {
      print("❌ Food upload failed: $e");
      return null;
    }
  }
}
