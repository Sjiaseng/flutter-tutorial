import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserRepository {
  static final _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return _db.collection('users').snapshots();
  }

  static Future<bool> doesUserExist(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.exists;
  }

  static Future<UserModel> getUserById(String id) async {
    final doc = await _db.collection('users').doc(id).get();
    return UserModel.fromFirestore(doc);
  }
}
