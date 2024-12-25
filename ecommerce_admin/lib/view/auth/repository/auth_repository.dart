import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class AppConstants {
  static const String collectionAdmin = 'collectionAdmin';
  static const String themeMode = 'themeMode';
}

class AuthRepository {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final Future<SharedPreferences> _sharedPref = SharedPreferences.getInstance();

  // Hardcoded email and password
  static const String _adminEmail = 'yihenfoong@gmail.com';
  static const String _adminPassword = 'admin';

  // Check if the user is an admin by their uid
  static Future<bool> isAdmin(String uid) async {
    return await _retryFirestoreOperation(() async {
      final snapshot = await _db.collection(AppConstants.collectionAdmin).doc(uid).get();
      return snapshot.exists;
    });
  }

  // Set the theme preference
  static Future<void> setTheme(bool isLightTheme) async {
    final SharedPreferences prefs = await _sharedPref;
    await prefs.setBool(AppConstants.themeMode, isLightTheme);
  }

  // Get the theme preference
  static Future<bool> getTheme() async {
    final SharedPreferences prefs = await _sharedPref;
    return prefs.getBool(AppConstants.themeMode) ?? true;
  }

  // Retry Firestore operations in case of failures
  static Future<T> _retryFirestoreOperation<T>(Future<T> Function() operation,
      {int maxRetries = 5, Duration delay = const Duration(seconds: 2)}) async {
    int retryCount = 0;
    while (true) {
      try {
        return await operation();
      } catch (e) {
        retryCount++;
        if (retryCount >= maxRetries) {
          rethrow;
        }
        await Future.delayed(delay * retryCount);
      }
    }
  }

  // Validate login credentials with hardcoded email and password
  static Future<bool> validateLogin(String email, String password) async {
    try {
      // Check if provided email and password match the hardcoded values
      if (email == _adminEmail && password == _adminPassword) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error validating login: $e');
      return false;
    }
  }
}
