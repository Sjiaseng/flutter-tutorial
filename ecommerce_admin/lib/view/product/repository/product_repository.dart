import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/view/category/models/comment_model.dart';
import 'package:ecommerce_admin/view/product/models/product_model.dart';
import 'package:ecommerce_admin/view/product/models/purchase_model.dart';
import 'package:ecommerce_admin/view/product/models/review_model.dart';

class ProductRepository {
  static final _db = FirebaseFirestore.instance;

  static Future<void> addNewProduct(ProductModel productModel, PurchaseModel purchaseModel) {
    final wb = _db.batch();
    final productDoc = _db.collection('products').doc();
    final purchaseDoc = _db.collection('purchases').doc();
    productModel = productModel.copyWith(productId: productDoc.id);
    purchaseModel = purchaseModel.copyWith(productId: productDoc.id, purchaseId: purchaseDoc.id);
    wb.set(productDoc, productModel.toMap());
    wb.set(purchaseDoc, purchaseModel.toMap());

    return wb.commit();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() {
    return _db.collection('products').snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllPurchases() {
    return _db.collection('purchases').snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductsByCategory(String categoryName) {
    return _db
        .collection('products')
        .where('category.categoryName', isEqualTo: categoryName)
        .snapshots();
  }

  static Future<void> updateProductField(String productId, Map<String, dynamic> map) {
    return _db.collection('products').doc(productId).update(map);
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllPurchaseByProductId(String productId) {
    return _db
        .collection('purchases')
        .where('productId', isEqualTo: productId)
        .get();
  }

  static Future<void> repurchase(PurchaseModel purchaseModel, ProductModel productModel) async {
    final wb = _db.batch();
    final doc = _db.collection('purchases').doc();
    purchaseModel = purchaseModel.copyWith(purchaseId: doc.id);
    wb.set(doc, purchaseModel.toMap());

    final productDoc = _db.collection('products').doc(productModel.productId);
    wb.update(productDoc, {'stock': (productModel.stock + purchaseModel.purchaseQuantity)});

    return wb.commit();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getCommentsByProduct(String productId) {
    return _db
        .collection('products')
        .doc(productId)
        .collection('comments')
        .get();
  }

  static Future<void> approveComment(String productId, CommentModel commentModel) {
    return _db.collection('products')
        .doc(productId)
        .collection('comments')
        .doc(commentModel.commentId)
        .update({'approved': true});
  }

  static Future<void> updateProduct(ProductModel productModel) {
    return _db.collection('products')
        .doc(productModel.productId)
        .update(productModel.toMap());
  }

  static Future<void> deleteProduct(String productId) {
    return _db.collection('products').doc(productId).delete();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllReviewsByProduct(String productId) {
    return _db
        .collection('products')
        .doc(productId)
        .collection('reviews')
        .snapshots();
  }

  static Future<void> addReview(ReviewModel reviewModel) {
    final doc = _db.collection('products')
        .doc(reviewModel.productId)
        .collection('reviews')
        .doc();
    reviewModel = reviewModel.copyWith(reviewId: doc.id);
    return doc.set(reviewModel.toMap());
  }
}
