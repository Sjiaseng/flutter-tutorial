import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin/view/category/provider/category_provider.dart';
import 'package:ecommerce_admin/view/product/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../category/models/category_model.dart';
import 'provider/product_provider.dart';

class ViewProductPage extends StatefulWidget {
  const ViewProductPage({super.key});
  static const String routeName = '/viewproductpage';

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  CategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) => Consumer<ProductProvider>(
          builder: (context, provider, child) {
            // Create a list of categories including the "All" option
            final categories = [
              ...categoryProvider.getCategoriesForFiltering()
            ];

            // Ensure the selected category is in the categories list
            if (categoryModel != null && !categories.contains(categoryModel)) {
              categoryModel = categories.firstWhere(
                    (category) => category.categoryId == categoryModel!.categoryId,
                orElse: () => categories.first,
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<CategoryModel>(
                    isExpanded: true,
                    hint: const Text('Select Category'),
                    value: categoryModel,
                    items: categories.map((catModel) {
                      return DropdownMenuItem(
                        value: catModel,
                        child: Text(catModel.categoryName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        categoryModel = value;
                      });
                      if (categoryModel!.categoryId == 'all') {
                        provider.getAllProducts();
                      } else {
                        provider.getAllProductsByCategory(categoryModel!.categoryName);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.productList.length,
                    itemBuilder: (context, index) {
                      final product = provider.productList[index];
                      return ListTile(
                        onTap: () => Navigator.pushNamed(
                          context,
                          ProductDetailsPage.routeName,
                          arguments: product,
                        ),
                        leading: CachedNetworkImage(
                          width: 50,
                          imageUrl: product.thumbnailImageUrl,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        title: Text(product.productName),
                        subtitle: Text(product.category.categoryName),
                        trailing: Text('Stock: ${product.stock}'),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
