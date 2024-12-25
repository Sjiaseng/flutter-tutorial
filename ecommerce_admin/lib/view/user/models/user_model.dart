import 'package:cloud_firestore/cloud_firestore.dart';
import 'address_model.dart';

class UserModel {
  final String userId;
  final String userName;
  final String email;
  final String phone;
  final String gender;
  final String imageUrl;
  final AddressModel address;
  final String fcmToken;
  final Timestamp creationTime;

  UserModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.imageUrl,
    required this.address,
    required this.fcmToken,
    required this.creationTime,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      userId: data['userId'],
      userName: data['userName'],
      email: data['email'],
      phone: data['phone'],
      gender: data['gender'],
      imageUrl: data['imageUrl'],
      address: AddressModel(
        city: data['address']['city'],
        state: data['address']['state'],
        street: data['address']['street'],
        zip: data['address']['zip'],
      ),
      fcmToken: data['fcmToken'],
      creationTime: data['creationTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'imageUrl': imageUrl,
      'address': {
        'city': address.city,
        'state': address.state,
        'street': address.street,
        'zip': address.zip,
      },
      'fcmToken': fcmToken,
      'creationTime': creationTime,
    };
  }

  UserModel copyWith({
    String? userId,
    String? userName,
    String? email,
    String? phone,
    String? gender,
    String? imageUrl,
    AddressModel? address,
    String? fcmToken,
    Timestamp? creationTime,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      imageUrl: imageUrl ?? this.imageUrl,
      address: address ?? this.address,
      fcmToken: fcmToken ?? this.fcmToken,
      creationTime: creationTime ?? this.creationTime,
    );
  }
}