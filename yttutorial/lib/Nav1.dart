import 'package:flutter/material.dart';
import 'package:yttutorial/Nav2.dart';
import 'package:yttutorial/first_Tutorial.dart';

class T2FirstPage extends StatelessWidget {
  const T2FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("First Page"),
          ),
          body: Center(
            child: ElevatedButton(
              child: Text("Go to Second Page."),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const T2SecondPage(),
                  ),
                );
              },
            ),
          ),
      ),
    );
  }
}

// to be included in the main.dart
class MyMain extends StatelessWidget {
  const MyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

//to be included in the main.dart (2nd Method)
class MyMain2 extends StatelessWidget {
  const MyMain2({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
      routes: {
        '/secondpage' :(context) => SecondPage(), // can add more
      },
    );
  }
}

class T2SecMethod extends StatelessWidget {
  const T2SecMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("First Page"),
          ),
          body: Center(
            child: ElevatedButton(
              child: const Text("Go to Second Page."),
              onPressed: () {
                Navigator.pushNamed(context, '/secondpage');
              },
            ),
          ),
      ),
    );
  }
}