import 'package:ecommerce_admin/view/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_admin/view/dashboard/dashboard_page.dart';

class LauncherPage extends StatefulWidget {
  static const routeName = '/launcher';

  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, DashboardPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), 
      ),
    );
  }
}
