import 'package:ecommerce_admin/core/components/custom_button.dart';
import 'package:ecommerce_admin/core/components/custom_text_form_field.dart';
import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/core/extensions/context.dart';
import 'package:ecommerce_admin/core/extensions/style.dart';
import 'package:ecommerce_admin/view/category/models/category_model.dart';
import 'package:ecommerce_admin/view/category/provider/category_provider.dart';
import 'package:ecommerce_admin/view/product/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductEditDialog extends StatefulWidget {
  final ProductModel productModel;
  final Function(ProductModel) onProductUpdated;
  const ProductEditDialog({super.key, required this.productModel, required this.onProductUpdated});

  @override
  State<ProductEditDialog> createState() => _ProductEditDialogState();
}

class _ProductEditDialogState extends State<ProductEditDialog> {
  late TextEditingController nameController;
  late TextEditingController salePriceController;
  late TextEditingController discountController;
  late TextEditingController shortDescriptionController;
  late TextEditingController longDescriptionController;

  late ProductModel editedProduct;

  @override
  void initState() {
    super.initState();
    editedProduct = widget.productModel;

    nameController = TextEditingController(text: widget.productModel.productName);
    salePriceController = TextEditingController(text: widget.productModel.salePrice.toStringAsFixed(2));
    discountController = TextEditingController(text: widget.productModel.discount.toStringAsFixed(2));
    shortDescriptionController = TextEditingController(text: widget.productModel.shortDescription);
    longDescriptionController = TextEditingController(text: widget.productModel.longDescription);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingMedium),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        'Edit Product',
                        style: const TextStyle().semiBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                      ),
                      const SizedBox(height: Dimensions.paddingMedium),
                      CustomTextFormField(
                        controller: nameController,
                        hintText: 'Product Name',
                        labelText: 'Product Name',
                        onChanged: (value) {
                          setState(() {
                            editedProduct = editedProduct.copyWith(productName: value);
                          });
                        },
                      ),
                      const SizedBox(height: Dimensions.paddingSmall),
                      Consumer<CategoryProvider>(
                        builder: (context, categoryProvider, child) {
                          return DropdownButtonFormField<CategoryModel>(
                            decoration: const InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(),
                            ),
                            isExpanded: true,
                            hint: const Text('Category'),
                            value: categoryProvider.categoryList.firstWhere(
                                    (category) => category.categoryId == editedProduct.category.categoryId,
                                orElse: () => categoryProvider.categoryList.first),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a category';
                              }
                              return null;
                            },
                            items: categoryProvider.categoryList
                                .map((catModel) => DropdownMenuItem(
                              key: ValueKey(catModel.categoryId),
                              value: catModel,
                              child: Text(
                                catModel.categoryName,
                              ),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                editedProduct = editedProduct.copyWith(category: value!);
                              });
                            },
                          );
                        },
                      ),
                      const SizedBox(height: Dimensions.paddingSmall),
                      CustomTextFormField(
                        controller: salePriceController,
                        hintText: 'Sale Price',
                        labelText: 'Sale Price',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            editedProduct = editedProduct.copyWith(salePrice: double.tryParse(value) ?? 0.0);
                          });
                        },
                      ),
                      const SizedBox(height: Dimensions.paddingSmall),
                      CustomTextFormField(
                        controller: discountController,
                        hintText: 'Price Discount (%)',
                        labelText: 'Price Discount (%)',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            editedProduct = editedProduct.copyWith(discount: double.tryParse(value) ?? 0.0);
                          });
                        },
                      ),
                      const SizedBox(height: Dimensions.paddingSmall),
                      CustomTextFormField(
                        controller: shortDescriptionController,
                        hintText: 'Short Description',
                        labelText: 'Short Description',
                        onChanged: (value) {
                          setState(() {
                            editedProduct = editedProduct.copyWith(shortDescription: value);
                          });
                        },
                      ),
                      const SizedBox(height: Dimensions.paddingSmall),
                      CustomTextFormField(
                        controller: longDescriptionController,
                        hintText: 'Long Description',
                        labelText: 'Long Description',
                        onChanged: (value) {
                          setState(() {
                            editedProduct = editedProduct.copyWith(longDescription: value);
                          });
                        },
                      ),
                      const SizedBox(height: Dimensions.paddingSmall),
                      CustomButton(
                        width: double.infinity,
                        text: 'Update',
                        onPressed: () {
                          widget.onProductUpdated(editedProduct);
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: Dimensions.paddingSmall),
                    ]),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: context.theme.disabledColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    salePriceController.dispose();
    discountController.dispose();
    shortDescriptionController.dispose();
    longDescriptionController.dispose();
    super.dispose();
  }
}
