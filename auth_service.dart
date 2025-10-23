import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  /// Save user data to Firestore (only if new)
  static Future<void> saveUserData(User? user, {String? name, String? imageUrl}) async {
    if (user == null) return;
    final userRef = FirebaseFirestore.instance.collection("users").doc(user.uid);
    final doc = await userRef.get();

    if (!doc.exists) {
      await userRef.set({
        "uid": user.uid,
        "name": name ?? user.displayName ?? "",
        "email": user.email,
        "imageUrl": imageUrl,
        "createdAt": DateTime.now(),
      });
    }
  }
}
