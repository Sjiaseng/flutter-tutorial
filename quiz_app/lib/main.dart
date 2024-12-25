import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
        ),
      child:
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 350,
              width:350, 
              child: Image.asset('images/quiz-logo.png'),
            ),
            
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: const Text(
                'Learn Flutter the Fun Way!', style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 18, 
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: const BeveledRectangleBorder(),
                  elevation: 2.0,
                ),
              child: const Text('Start Quiz', 
              style: TextStyle(
                  color: Colors.white,
                ),
              ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
