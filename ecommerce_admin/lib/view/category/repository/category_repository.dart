import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/view/category/models/category_model.dart';

import '../../../core/constants/constants.dart';

class CategoryRepository {
  static final _db = FirebaseFirestore.instance;

  static Future<void> addCategory(CategoryModel categoryModel) async {
    final catDoc = _db.collection('categories').doc();
    categoryModel = CategoryModel(
      categoryId: catDoc.id,
      categoryName: categoryModel.categoryName,
    );
    return catDoc.set(categoryModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection('categories').snapshots();

  static Future<void> updateCategory(CategoryModel categoryModel) {
    return _db
        .collection('categories')
        .doc(categoryModel.categoryId)
        .update(categoryModel.toMap());
  }

  static Future<void> deleteCategory(String? categoryId) {
    return _db.collection('categories').doc(categoryId).delete();
  }
}
