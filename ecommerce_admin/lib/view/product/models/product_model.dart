import 'package:cloud_firestore/cloud_firestore.dart';

import '../../category/models/category_model.dart';


class ProductModel {
  final String productId;
  final String productName;
  final String shortDescription;
  final String longDescription;
  final double salePrice;
  final double discount;
  final int stock;
  final bool available;
  final bool featured;
  final String thumbnailImageUrl;
  final List<String> additionalImages;
  final CategoryModel category;
  final double avgRating;
  final int ratingCount;
  Timestamp? createdAt;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.shortDescription,
    required this.longDescription,
    required this.salePrice,
    required this.discount,
    required this.stock,
    required this.available,
    required this.featured,
    required this.thumbnailImageUrl,
    required this.additionalImages,
    required this.category,
    required this.avgRating,
    required this.ratingCount,
    this.createdAt,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      productId: data['productId'],
      productName: data['productName'],
      shortDescription: data['shortDescription'],
      longDescription: data['longDescription'],
      salePrice: (data['salePrice'] as num).toDouble(),
      discount: (data['discount'] as num).toDouble(),
      stock: data['stock'],
      available: data['available'],
      featured: data['featured'],
      thumbnailImageUrl: data['thumbnailImageUrl'],
      additionalImages: List<String>.from(data['additionalImages']),
      category: CategoryModel.fromMap(data['category']),
      avgRating: (data['avgRating'] as num).toDouble(),
      ratingCount: data['ratingCount'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'salePrice': salePrice,
      'discount': discount,
      'stock': stock,
      'available': available,
      'featured': featured,
      'thumbnailImageUrl': thumbnailImageUrl,
      'additionalImages': additionalImages,
      'category': category.toMap(),
      'avgRating': avgRating,
      'ratingCount': ratingCount,
      'createdAt': createdAt,
    };
  }

  ProductModel copyWith({
    String? productId,
    String? productName,
    String? shortDescription,
    String? longDescription,
    double? salePrice,
    double? discount,
    int? stock,
    bool? available,
    bool? featured,
    String? thumbnailImageUrl,
    List<String>? additionalImages,
    CategoryModel? category,
    double? avgRating,
    int? ratingCount,
    Timestamp? createdAt,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      salePrice: salePrice ?? this.salePrice,
      discount: discount ?? this.discount,
      stock: stock ?? this.stock,
      available: available ?? this.available,
      featured: featured ?? this.featured,
      thumbnailImageUrl: thumbnailImageUrl ?? this.thumbnailImageUrl,
      additionalImages: additionalImages ?? this.additionalImages,
      category: category ?? this.category,
      avgRating: avgRating ?? this.avgRating,
      ratingCount: ratingCount ?? this.ratingCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
