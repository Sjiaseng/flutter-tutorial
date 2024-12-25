import 'package:flutter/material.dart';

class T2SecondPage extends StatelessWidget {
  const T2SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Second Page"),
        ),
      ),
    );
  }
}