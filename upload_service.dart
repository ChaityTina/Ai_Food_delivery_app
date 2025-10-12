import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';

class UploadService {
  static final _cloudinary = CloudinaryPublic(
    'dosz3fmol',   // same cloud
    'r2cxmlx4',    // unsigned upload preset for users
    cache: false,
  );

  static Future<String?> uploadUserImage(File file) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      return response.secureUrl; // ✅ Profile image URL
    } catch (e) {
      print("❌ User upload failed: $e");
      return null;
    }
  }
}
