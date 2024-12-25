import 'package:ecommerce_admin/view/category/models/category_model.dart';
import 'package:ecommerce_admin/view/category/repository/category_repository.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];

  Future<void> addCategory(String categoryName) async {
    final categoryModel = CategoryModel(
      categoryId: '', // Will be set in the repository
      categoryName: categoryName,
    );
    await CategoryRepository.addCategory(categoryModel);
    getAllCategories(); // Refresh the category list after adding
  }

  getAllCategories() {
    CategoryRepository.getAllCategories().listen((snapshot) {
      categoryList = List.generate(snapshot.docs.length,
              (index) => CategoryModel.fromMap(snapshot.docs[index].data()));
      categoryList.sort((model1, model2) =>
          model1.categoryName.compareTo(model2.categoryName));
      notifyListeners();
    });
  }

  List<CategoryModel> getCategoriesForFiltering() {
    return <CategoryModel>[
      CategoryModel(categoryName: "All", categoryId: 'all'),
      ...categoryList,
    ];
  }

  List<CategoryModel> get getAllCategoriesList => categoryList;

  Future<void> updateCategory(String id, String name) {
    final categoryModel = CategoryModel(
      categoryId: id,
      categoryName: name,
    );
    return CategoryRepository.updateCategory(categoryModel);
  }

  Future<void> deleteCategory(String? categoryId) {
    return CategoryRepository.deleteCategory(categoryId);
  }
}
