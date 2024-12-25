import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Hardcoded email and password
  static const String _adminEmail = 'yihenfoong@gmail.com';
  static const String _adminPassword = 'admin';

  // Login admin method with hardcoded email and password
  static Future<bool> loginAdmin(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _adminEmail,
        password: _adminPassword,
      );
      String uid = userCredential.user!.uid;

      // Check if the user is in the collectionAdmin collection
      DocumentSnapshot adminSnapshot = await _db.collection('collectionAdmin').doc(uid).get();
      if (adminSnapshot.exists) {
        return true;
      } else {
        await logout(); // Logout if not an admin
        return false;
      }
    } catch (e) {
      print('Error logging in: $e');
      return false;
    }
  }

  // Logout method
  static Future<void> logout() async {
    try {
      await _auth.signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clear all saved preferences
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  // Get theme preference from shared preferences
  static Future<bool> getThemeFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('themeMode') ?? true;
  }
}
