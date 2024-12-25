import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseModel {
  final String purchaseId;
  final String productId;
  final double purchasePrice;
  final int purchaseQuantity;
  final Map<String, dynamic> date; 

  PurchaseModel({
    required this.purchaseId,
    required this.productId,
    required this.purchasePrice,
    required this.purchaseQuantity,
    required this.date,
  });

  factory PurchaseModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PurchaseModel(
      purchaseId: data['purchaseId'],
      productId: data['productId'],
      purchasePrice: data['purchasePrice'].toDouble(),
      purchaseQuantity: data['purchaseQuantity'],
      date: data['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'purchaseId': purchaseId,
      'productId': productId,
      'purchasePrice': purchasePrice,
      'purchaseQuantity': purchaseQuantity,
      'date': date,
    };
  }

  PurchaseModel copyWith({
    String? purchaseId,
    String? productId,
    double? purchasePrice,
    int? purchaseQuantity,
    Map<String, dynamic>? date,
  }) {
    return PurchaseModel(
      purchaseId: purchaseId ?? this.purchaseId,
      productId: productId ?? this.productId,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      purchaseQuantity: purchaseQuantity ?? this.purchaseQuantity,
      date: date ?? this.date,
    );
  }
}
