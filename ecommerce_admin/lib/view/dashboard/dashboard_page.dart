import 'dart:convert';
import 'package:ecommerce_admin/core/components/confirmation_dialog.dart';
import 'package:ecommerce_admin/core/components/custom_appbar.dart';
import 'package:ecommerce_admin/core/constants/dimensions.dart';
import 'package:ecommerce_admin/core/extensions/context.dart';
import 'package:ecommerce_admin/core/themes/themes_provider.dart';
import 'package:ecommerce_admin/core/utils/notification_helper.dart';
import 'package:ecommerce_admin/view/auth/login_page.dart';
import 'package:ecommerce_admin/view/auth/services/auth_service.dart';
import 'package:ecommerce_admin/view/category/provider/category_provider.dart';
import 'package:ecommerce_admin/view/dashboard/widgets/badge_view.dart';
import 'package:ecommerce_admin/view/dashboard/widgets/dashboard_item_view.dart';
import 'package:ecommerce_admin/view/dashboard/models/dashboard_model.dart';
import 'package:ecommerce_admin/view/dashboard/launcher_page.dart';
import 'package:ecommerce_admin/view/notification/provider/notification_provider.dart';
import 'package:ecommerce_admin/view/order/provider/order_provider.dart';
import 'package:ecommerce_admin/view/product/provider/product_provider.dart';
import 'package:ecommerce_admin/view/user/provider/user_provider.dart';
import 'package:ecommerce_admin/core/constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static const String routeName = '/dashboardpage';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    Provider.of<ThemeProvider>(context, listen: false).getTheme();
    setupInteractedMessage();
    notificationPermission();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await Provider.of<CategoryProvider>(context, listen: false).getAllCategories();
      await Provider.of<ProductProvider>(context, listen: false).getAllProducts();
      await Provider.of<ProductProvider>(context, listen: false).getAllPurchases();
      await Provider.of<OrderProvider>(context, listen: false).getOrderConstants();
      await Provider.of<OrderProvider>(context, listen: false).getOrders();
      await Provider.of<UserProvider>(context, listen: false).getAllUser();
      await Provider.of<NotificationProvider>(context, listen: false).getAllNotification();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading data in didChangeDependencies: $e');
      }
    }
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      NotificationHelper.handleBackgroundNotification(initialMessage);
    }
  }

  void notificationPermission() async {
    if (!await NotificationHelper.checkNotificationPermission()) {
      await NotificationHelper.requestNotificationPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(), // This removes the back button
        title: const Center(
          child: Text(
            'Dashboard',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) => IconButton(
              onPressed: () => themeProvider.toggleTheme(),
              icon: themeProvider.isLightTheme
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ConfirmationDialog(
                  onYes: () => AuthService.logout().then((value) =>
                      Navigator.pushReplacementNamed(
                          context, LoginPage.routeName)),
                  body: 'You want to logout?',
                ),
              );
            },
            icon: Icon(Icons.logout, color: context.theme.cardColor),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/icons/logo.png',
              fit: BoxFit.contain,
              width: 200, // Adjust the size as needed
            ),
          ),
          GridView.builder(
            padding: const EdgeInsets.all(Dimensions.paddingSmall),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: dashboardModelList.length,
            itemBuilder: (context, index) {
              final model = dashboardModelList[index];
              if (model.title == 'Notification') {
                final count =
                    Provider.of<NotificationProvider>(context).totalUnreadMessage;
                return DashboardItemView(
                  model: model,
                  badge: count > 0 ? BadgeView(count: count) : null,
                );
              }
              return DashboardItemView(model: model);
            },
          ),
        ],
      ),
    );
  }

  void _sendNotification() async {
    const url = 'https://fcm.googleapis.com/fcm/send';
    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };
    final body = {
      "to": "/topics/promo",
      "notification": {
        "title": "Breaking News",
        "body": "New news story available."
      },
      "data": {
        "key": "promo",
        "value": "PB293473"
      }
    };

    try {
      final response = await http.post(Uri.parse(url), headers: header, body: json.encode(body));
      if (kDebugMode) {
        print('STATUS CODE: ${response.statusCode}');
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }
}

