import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin/core/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/components/custom_appbar.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/dimensions.dart';
import '../../core/utils/helper_functions.dart';
import '../category/models/comment_model.dart';
import '../product/models/product_model.dart';
import '../product/provider/product_provider.dart';
import '../product/product_repurchase_page.dart';
import '../product/widgets/photo_frame_view.dart';
import '../product/widgets/product_edit_dialog.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});
  static const String routeName = '/productdetailspage';

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel productModel;
  late ProductProvider productProvider;
  late Size size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    final object = ModalRoute.of(context)!.settings.arguments;
    if (object is String) {
      productModel = productProvider.getProductByIdFromCache(object);
    } else {
      productModel = object as ProductModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: productModel.productName,
        actions: [
          Consumer<ProductProvider>(
            builder: (context, provider, child) => IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => ProductEditDialog(
                    productModel: productModel,
                    onProductUpdated: (updatedProductModel) async {
                      EasyLoading.show(status: 'Updating...');
                      await provider.updateProduct(updatedProductModel);
                      EasyLoading.dismiss();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('Do you want to delete this product?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          EasyLoading.show(status: 'Deleting...');
                          await productProvider.deleteProduct(productModel.productId);
                          EasyLoading.dismiss();
                          if (mounted) Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            imageUrl: productModel.thumbnailImageUrl,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SizedBox(
            height: 75,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PhotoFrameView(
                    onImagePressed: () {
                      _showImageInDialog(0);
                    },
                    url: productModel.additionalImages.isNotEmpty ? productModel.additionalImages[0] : '',
                    child: IconButton(
                      onPressed: () {
                        _addImage(0);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  PhotoFrameView(
                    onImagePressed: () {
                      _showImageInDialog(1);
                    },
                    url: productModel.additionalImages.length > 1 ? productModel.additionalImages[1] : '',
                    child: IconButton(
                      onPressed: () {
                        _addImage(1);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  PhotoFrameView(
                    onImagePressed: () {
                      _showImageInDialog(2);
                    },
                    url: productModel.additionalImages.length > 2 ? productModel.additionalImages[2] : '',
                    child: IconButton(
                      onPressed: () {
                        _addImage(2);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  ProductRepurchasePage.routeName,
                  arguments: productModel,
                ),
                child: const Text('Re-Purchase'),
              ),
              const SizedBox(width: Dimensions.paddingExtraSmall),
              OutlinedButton(
                onPressed: _showPurchaseHistory,
                child: const Text('Purchase history'),
              ),
            ],
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(productModel.productName),
                Text('Stock: ${productModel.stock}'),
              ],
            ),
            subtitle: Text('Category: ${productModel.category.categoryName}'),
          ),
          ListTile(
            title: Text('Sale Price: $currencySymbol${productModel.salePrice}'),
            subtitle: Text("Discount: ${productModel.discount}%"),
            trailing: Text("$currencySymbol${productProvider.priceAfterDiscount(productModel.salePrice, productModel.discount)}"),
          ),
          SwitchListTile(
            value: productModel.available,
            onChanged: (value) {
              setState(() {
                productModel = productModel.copyWith(available: value);
              });
              productProvider.updateProductField(
                productModel.productId,
                'available',
                value,
              );
            },
            title: const Text('Available'),
          ),
          SwitchListTile(
            value: productModel.featured,
            onChanged: (value) {
              setState(() {
                productModel = productModel.copyWith(featured: value);
              });
              productProvider.updateProductField(
                productModel.productId,
                'featured',
                value,
              );
            },
            title: const Text('Featured'),
          ),
          ListTile(
            title: const Text('Short Description'),
            subtitle: Text(productModel.shortDescription),
          ),
          ListTile(
            title: const Text('Long Description'),
            subtitle: Text(productModel.longDescription),
          ),
          ListTile(
            title: const Text('Average Rating'),
            trailing: Text('${productModel.avgRating.toStringAsFixed(2)} (${productModel.ratingCount})', style: context.textTheme.titleMedium),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingMedium),
            child: Text(
              'All Comments',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          FutureBuilder<List<CommentModel>>(
            future: productProvider.getCommentsByProduct(productModel.productId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final commentList = snapshot.data!;
                if (commentList.isEmpty) {
                  return const Center(child: Text('No comments found'));
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: commentList.map((comment) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(comment.userModel.userName ?? comment.userModel.email),
                            subtitle: Text(comment.date),
                            leading: comment.userModel.imageUrl == null
                                ? const Icon(Icons.person)
                                : CachedNetworkImage(
                              width: 70,
                              height: 100,
                              fit: BoxFit.cover,
                              imageUrl: comment.userModel.imageUrl!,
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: Dimensions.paddingExtraLarge),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(comment.comment),
                                ),
                                OutlinedButton(
                                  onPressed: comment.approved ? null : () => _approveComment(comment),
                                  child: const Text('Approve this comment'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                }
              }
              if (snapshot.hasError) {
                return const Text('Failed to load comments');
              }
              return const Center(child: Text('Loading comments'));
            },
          ),
          const SizedBox(height: Dimensions.heightLarge),
        ],
      ),
    );
  }

  void _showPurchaseHistory() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final purchaseList = productProvider.getPurchaseByProductId(productModel.productId);
        return ListView.builder(
          itemCount: purchaseList.length,
          itemBuilder: (context, index) {
            final purchaseModel = purchaseList[index];
            return ListTile(
              title: Text(getFormattedDate(purchaseModel.date['timestamp'])),
              subtitle: Text('BDT: ${purchaseModel.purchasePrice}'),
              trailing: Text('Quantity: ${purchaseModel.purchaseQuantity}'),
            );
          },
        );
      },
    );
  }

  void _addImage(int index) async {
    final selectedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedFile != null) {
      EasyLoading.show(status: 'Please wait');
      final imageModel = await productProvider.uploadImage(selectedFile.path);
      final previousImageList = productModel.additionalImages;
      if (previousImageList.length > index) {
        previousImageList[index] = imageModel.imageDownloadUrl;
      } else {
        previousImageList.add(imageModel.imageDownloadUrl);
      }
      productProvider.updateProductField(productModel.productId, 'additionalImages', previousImageList).then(
            (value) {
          setState(() {
            productModel = productModel.copyWith(additionalImages: previousImageList);
          });
          showMsg(context, 'Uploaded');
          EasyLoading.dismiss();
        },
      ).catchError((error) {
        showMsg(context, 'Failed to upload');
        EasyLoading.dismiss();
      });
    }
  }

  void _showImageInDialog(int index) {
    final url = productModel.additionalImages.length > index ? productModel.additionalImages[index] : '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: CachedNetworkImage(
          width: size.height / 2,
          height: 200,
          fit: BoxFit.cover,
          imageUrl: url,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                _addImage(index);
                await productProvider.deleteImage(url);
              } catch (error) {
                if (mounted) showMsg(context, 'Failed to Update');
              }
            },
            child: const Text('CHANGE'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              EasyLoading.show(status: "Deleting image");
              setState(() {
                if (productModel.additionalImages.length > index) {
                  productModel.additionalImages[index] = '';
                }
              });
              try {
                await productProvider.deleteImage(url);
                await productProvider.updateProductField(productModel.productId, 'additionalImages', productModel.additionalImages);
                EasyLoading.dismiss();
                if (mounted) showMsg(context, 'Deleted');
              } catch (error) {
                EasyLoading.dismiss();
                if (mounted) showMsg(context, 'Failed to Delete');
              }
            },
            child: const Text('DELETE'),
          ),
        ],
      ),
    );
  }

  void _approveComment(CommentModel commentModel) async {
    EasyLoading.show(status: 'Please wait');
    await productProvider.approveComment(productModel.productId, commentModel);
    EasyLoading.dismiss();
    if (mounted) showMsg(context, 'Comment Approved');
    setState(() {});
  }
}
