import 'package:flutter/material.dart';

// Section 1
/*
void main() {

  //runApp(const MaterialApp(home: Center(child: Text('Hello World'))));

  //highlight right click - format document (space first after "(" except text widget)

  /*
  runApp(
    const MaterialApp(
      home: Center(
        child: Text('Hello World'),
      ),
    ),
  );
  */


  runApp(
    MaterialApp( 
      home: Scaffold(
      backgroundColor: Colors.blueGrey,

      appBar: AppBar(
        title: const Text('Hello World'),
        backgroundColor: Colors.blueGrey[900],
      ),
      
      body: const Center(
        child: Image(
          image:
            NetworkImage('https://www.w3schools.com/w3css/img_lights.jpg')
        ),
      ),
    ),
  ),
);

}
*/

// Section 2


void main() {
  /*
  runApp(
    MaterialApp(
      home: Center(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          color: Colors.amber[600],
          width: 48.0,
          height: 48.0,
        ),
      ),
    ),
  );
  */

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 26, 2, 80),
                Color.fromARGB(255, 45, 7, 98),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Text('Hello World', 
            style: TextStyle(
              color: Colors.red,
              fontSize: 25,
              fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
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
