import 'package:flutter/material.dart';
import 'secondPage.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: GradientContainer(),
    ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}