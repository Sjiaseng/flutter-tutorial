import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'core/themes/dark_theme.dart';
import 'core/themes/light_theme.dart';
import 'core/themes/themes_provider.dart';
import 'core/utils/notification_helper.dart';
import 'view/auth/login_page.dart';
import 'view/auth/services/auth_service.dart';
import 'view/category/provider/category_provider.dart';
import 'view/product/add_product_page.dart';
import 'view/category/category_page.dart';
import 'view/dashboard/dashboard_page.dart';
import 'view/dashboard/launcher_page.dart';
import 'view/notification/notification_page.dart';
import 'view/order/order_details_page.dart';
import 'view/order/order_page.dart';
import 'view/product/product_details_page.dart';
import 'view/product/product_repurchase_page.dart';
import 'view/report/report_page.dart';
import 'view/setting/settings_page.dart';
import 'view/user/user_list_page.dart';
import 'view/product/view_product_page.dart';
import 'view/notification/provider/notification_provider.dart';
import 'view/order/provider/order_provider.dart';
import 'view/product/provider/product_provider.dart';
import 'view/user/provider/user_provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  debugPrint("Handling a background message: ${message.toMap()}");
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  // Initialize other services
  bool isLightTheme = await AuthService.getThemeFromSharedPref();
  NotificationHelper notificationHelper = NotificationHelper();
  await notificationHelper.initNotifications();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint('FCM TOKEN: $fcmToken');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp(isLightTheme: isLightTheme));
}

class MyApp extends StatelessWidget {
  final bool isLightTheme;
  const MyApp({super.key, required this.isLightTheme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(isLightTheme)),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            initialRoute: LauncherPage.routeName,
            themeMode: themeProvider.isLightTheme ? ThemeMode.light : ThemeMode.dark,
            theme: LightTheme.theme,
            darkTheme: DarkTheme.theme,
            routes: {
              LauncherPage.routeName: (_) => LauncherPage(),
              LoginPage.routeName: (_) => const LoginPage(),
              DashboardPage.routeName: (_) => const DashboardPage(),
              AddProductPage.routeName: (_) => const AddProductPage(),
              ViewProductPage.routeName: (_) => const ViewProductPage(),
              ProductDetailsPage.routeName: (_) => const ProductDetailsPage(),
              CategoryPage.routeName: (_) => const CategoryPage(),
              OrderPage.routeName: (_) => const OrderPage(),
              ReportPage.routeName: (_) => const ReportPage(),
              SettingsPage.routeName: (_) => const SettingsPage(),
              ProductRepurchasePage.routeName: (_) => const ProductRepurchasePage(),
              UserListPage.routeName: (_) => const UserListPage(),
              OrderDetailsPage.routeName: (_) => const OrderDetailsPage(),
              NotificationPage.routeName: (_) => const NotificationPage(),
            },
          );
        },
      ),
    );
  }
}
