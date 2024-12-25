import 'package:flutter/material.dart';

// Section 1
class TutorialApp extends StatefulWidget {
  const TutorialApp({super.key});

  @override
  State<TutorialApp> createState() => _TutorialAppState();
}

class _TutorialAppState extends State<TutorialApp> {
  String buttonName = 'Click';
  int currentIndex = 0;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Title'),
          backgroundColor: Colors.blueAccent,
        ),
      body: 
        Center(
          child: currentIndex == 0 ? Container( // can use SizedBox also
            color: Colors.red,
            width: double.infinity,
            height: double.infinity,
            child: Row( // Row or Column -> sizedBox to control size
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      buttonName = 'Clicked';
                    });
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: const BeveledRectangleBorder(),
                  ),
                  child: Text(buttonName, style: const TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      buttonName = 'Clicked';
                    });
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: const BeveledRectangleBorder(),
                  ),
                  child: Text(buttonName, style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ) : GestureDetector(
                onTap: (){
                  setState(() {
                    isClicked = true;
                  });
                },
                child: isClicked == true ? Image.asset('images/image1.jpg') : 
                Image.network('https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg'),
              ),
              
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home,
                size: 24.0,
                semanticLabel: 'Home Icon',
                )
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(
                Icons.settings,
                size: 24.0,
                semanticLabel: 'Setting Icon',
                ),
            ),
          ],
          currentIndex: currentIndex,
          onTap: (int index){
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    ) ;
  }
}

// Section 2
class TutorialApp2 extends StatefulWidget {
  const TutorialApp2({super.key});

  @override
  State<TutorialApp2> createState() => _MyAppState2();
}

class _MyAppState2 extends State<TutorialApp2> {
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('First Page', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
          backgroundColor: Colors.blue,

        ),
        body: Center(
          child: ElevatedButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return const SecondPage();
                  }
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: const BeveledRectangleBorder(),
            ),
            child: const Text("Click", style: TextStyle(
              color: Colors.white,
              ),
            ),
          ),
        ),
      );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        title: const Text('Second Page', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Practical extends StatelessWidget {
  const Practical({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('My First App', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Image.network('https://www.negotiations.com/wp-content/uploads/2017/05/win-win-settlements_resized.jpg'),
      ),
      ),
    );
  }
}