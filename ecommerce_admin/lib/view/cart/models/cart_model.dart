class CartModel {
  final String productId;
  final String productName;
  final int quantity;
  final double salePrice;

  CartModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.salePrice,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      quantity: map['quantity'] ?? 0,
      salePrice: (map['salePrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'salePrice': salePrice,
    };
  }
}
