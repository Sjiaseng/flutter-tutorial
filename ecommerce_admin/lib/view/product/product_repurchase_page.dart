import 'package:ecommerce_admin/core/components/custom_appbar.dart';
import 'package:ecommerce_admin/view/dashboard/dashboard_page.dart';
import 'package:ecommerce_admin/view/product/models/product_model.dart';
import 'package:ecommerce_admin/view/product/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'models/purchase_model.dart';
import '../../core/utils/helper_functions.dart';

class ProductRepurchasePage extends StatefulWidget {
  const ProductRepurchasePage({super.key});
  static const String routeName = '/productrepurchasepage';

  @override
  State<ProductRepurchasePage> createState() => _ProductRepurchasePageState();
}

class _ProductRepurchasePageState extends State<ProductRepurchasePage> {
  late ProductModel productModel;
  final _formKey = GlobalKey<FormState>();
  final _purchasePriceController = TextEditingController();
  final _quantityController = TextEditingController();
  DateTime? purchaseDate;

  @override
  void didChangeDependencies() {
    productModel = ModalRoute.of(context)!.settings.arguments as ProductModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Re - Purchase'),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                productModel.productName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _purchasePriceController,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "Enter Purchase Price",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    if (num.parse(value) <= 0) {
                      return 'Price should be greater than 0';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "Enter Quantity",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    if (num.parse(value) <= 0) {
                      return 'Quantity should be greater than 0';
                    }
                    return null;
                  },
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: _selectDate,
                        icon: const Icon(Icons.calendar_month),
                        label: const Text('Select Purchase Date'),
                      ),
                      Text(purchaseDate == null
                          ? 'No date chosen'
                          : getFormattedDate(purchaseDate!)),
                    ],
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: _repurchase,
                child: const Text('Re-Purchase'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        purchaseDate = date;
      });
    }
  }

  @override
  void dispose() {
    _purchasePriceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _repurchase() {
    if (purchaseDate == null) {
      showMsg(context, 'Please Select purchase date');
      return;
    }
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: "Please wait...");
      final purchaseModel = PurchaseModel(
        purchaseId: '', // Ensure this is properly set
        productId: productModel.productId,
        purchaseQuantity: int.parse(_quantityController.text),
        purchasePrice: double.parse(_purchasePriceController.text),
        date: {
          'timestamp': purchaseDate!.toIso8601String(),
          'day': purchaseDate!.day,
          'month': purchaseDate!.month,
          'year': purchaseDate!.year,
        },
      );
      Provider.of<ProductProvider>(context, listen: false).repurchase(
        purchaseModel,
        productModel,
      ).then((value) {
        EasyLoading.dismiss();
        Navigator.pushNamedAndRemoveUntil(context, DashboardPage.routeName, (route) => false);
      }).catchError((error){
        EasyLoading.dismiss();
        showMsg(context, "Failed to save");
      });
    }
  }
}
