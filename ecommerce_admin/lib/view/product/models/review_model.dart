import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String reviewId;
  final String productId;
  final String userId;
  final String userName;
  final String reviewText;
  final int rating;
  final Timestamp reviewDate;

  ReviewModel({
    required this.reviewId,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.reviewText,
    required this.rating,
    required this.reviewDate,
  });

  factory ReviewModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ReviewModel(
      reviewId: data['reviewId'],
      productId: data['productId'],
      userId: data['userId'],
      userName: data['userName'],
      reviewText: data['reviewText'],
      rating: data['rating'],
      reviewDate: data['reviewDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reviewId': reviewId,
      'productId': productId,
      'userId': userId,
      'userName': userName,
      'reviewText': reviewText,
      'rating': rating,
      'reviewDate': reviewDate,
    };
  }

  ReviewModel copyWith({
    String? reviewId,
    String? productId,
    String? userId,
    String? userName,
    String? reviewText,
    int? rating,
    Timestamp? reviewDate,
  }) {
    return ReviewModel(
      reviewId: reviewId ?? this.reviewId,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      reviewText: reviewText ?? this.reviewText,
      rating: rating ?? this.rating,
      reviewDate: reviewDate ?? this.reviewDate,
    );
  }
}
