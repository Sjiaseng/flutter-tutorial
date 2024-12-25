import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();

}

class _ToDoPageState extends State<ToDoPage>{

  //text editing controller
  TextEditingController myController = TextEditingController();

  void greetUser(){
    setState(() {
      greetingMessage = "Hello, " + myController.text;
    });
  }

  String greetingMessage = "";

  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(greetingMessage),

              SizedBox(
                width: 350,
                child: TextField(
                  controller: myController,
                  decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Type Anything",
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: greetUser, 
                child: const Text('Tap')
              ),

            ],
          ),
        ),
      ),
    );
  }
}