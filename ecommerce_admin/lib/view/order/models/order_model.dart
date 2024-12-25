import 'package:cloud_firestore/cloud_firestore.dart';

import '../../cart/models/cart_model.dart';
import '../../user/models/address_model.dart';
import 'contact_info_model.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final ContactInfoModel contactInfo;
  final AddressModel deliveryAddress;
  final List<CartModel> productDetails;
  final String orderStatus;
  final String paymentMethod;
  final double deliveryCharge;
  final double discount;
  final double VAT;
  final double grandTotal;
  final DateTime orderDate;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.contactInfo,
    required this.deliveryAddress,
    required this.productDetails,
    required this.orderStatus,
    required this.paymentMethod,
    required this.deliveryCharge,
    required this.discount,
    required this.VAT,
    required this.grandTotal,
    required this.orderDate,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      orderId: data['orderId'],
      userId: data['userId'],
      contactInfo: ContactInfoModel.fromMap(data['contactInfo']),
      deliveryAddress: AddressModel.fromMap(data['deliveryAddress']),
      productDetails: List<CartModel>.from(data['productDetails'].map((item) => CartModel.fromMap(item))),
      orderStatus: data['orderStatus'],
      paymentMethod: data['paymentMethod'],
      deliveryCharge: (data['deliveryCharge'] as num).toDouble(),
      discount: (data['discount'] as num).toDouble(),
      VAT: (data['VAT'] as num).toDouble(),
      grandTotal: (data['grandTotal'] as num).toDouble(),
      orderDate: (data['orderDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'contactInfo': contactInfo.toMap(),
      'deliveryAddress': deliveryAddress.toMap(),
      'productDetails': productDetails.map((item) => item.toMap()).toList(),
      'orderStatus': orderStatus,
      'paymentMethod': paymentMethod,
      'deliveryCharge': deliveryCharge,
      'discount': discount,
      'VAT': VAT,
      'grandTotal': grandTotal,
      'orderDate': Timestamp.fromDate(orderDate),
    };
  }

  OrderModel copyWith({
    String? orderId,
    String? userId,
    ContactInfoModel? contactInfo,
    AddressModel? deliveryAddress,
    List<CartModel>? productDetails,
    String? orderStatus,
    String? paymentMethod,
    double? deliveryCharge,
    double? discount,
    double? VAT,
    double? grandTotal,
    DateTime? orderDate,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      contactInfo: contactInfo ?? this.contactInfo,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      productDetails: productDetails ?? this.productDetails,
      orderStatus: orderStatus ?? this.orderStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      discount: discount ?? this.discount,
      VAT: VAT ?? this.VAT,
      grandTotal: grandTotal ?? this.grandTotal,
      orderDate: orderDate ?? this.orderDate,
    );
  }
}
