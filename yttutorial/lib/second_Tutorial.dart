import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class Tutorial2 extends StatelessWidget {
  const Tutorial2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple[200],
        appBar: AppBar(
          title: const Text('My App'),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          leading: const Icon(Icons.menu),
          actions: [
            IconButton(
              onPressed: (){
                
              },
              icon: const Icon(Icons.logout),  
            ),
          ],
        ),

        //First Section

        /*
        1. After Body can Use Row / Column
        To position Row & Column, Use:
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        
        2. Using ListView for Scrollable Items
        Control Scroll Position, Use:
          scrollDirection: Axis.horizontal,
  
        */

        body: ListView( 
          scrollDirection: Axis.horizontal,
          children: [
            //first child
            Container(
              height: 200,
              width: 200,
              color: Colors.deepPurple
            ),

            //second child
            Expanded(
              flex: 2,
              child: 
              Container(
                color: Colors.deepPurple[400]
              ),
            ),
            //third child
            Expanded(
              child: //Expanded automatically fill up the screen
              Container(
                color: Colors.deepPurple[200]
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ListViewBuilder extends StatelessWidget {
    ListViewBuilder({super.key});

  final List names = [
    "Mitch", "Sharon", "Vince"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView.builder(
          itemCount: names.length, // can put integers also
          itemBuilder: (context, index) => ListTile(
            title: Text(names[index],
            ),
          ),
        ),
      ),
    );
  }
}


class Grid_View extends StatelessWidget {
  const Grid_View({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GridView.builder(
          itemCount: 64,
          // how many grid in each row
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8), 
          itemBuilder: (context, index) => Container(color: Colors.deepPurple,
            margin: const EdgeInsets.all(2),
            ),
          ),
      )
    );
  }
}

//stateless need refresh yourself
//stateful auto refresh (changes in data, UI, content etc...)

class Stack_Widget extends StatelessWidget {
  const Stack_Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack( 
          alignment: Alignment.center,// put container on top of other containers
          children: [
            // big box
            Container(
              height: 300,
              width: 300,
              color: Colors.deepPurple,
            ),
            // medium box
            Container(
              height: 200,
              width: 200,
              color: Colors.deepPurple[400],
            ),
            //small box
            Container(
              height: 100,
              width: 100,
              color: Colors.deepPurple[200],
            ),
          ],
        ),
      ),
    );
  }
}

class gestureTest extends StatelessWidget {
  gestureTest({super.key});

  void userTapped(){
    print("User Tapped!");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: userTapped,
            child: Container(
              height: 200,
              width: 200,
              color: Colors.deepPurple[200],
            )
          )
        )
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("My App"),
            backgroundColor: Colors.blue,
          ),
          drawer: Drawer(
            backgroundColor: Colors.deepPurple[100],
            child: Column(
              children: [
                const DrawerHeader(
                  child: Icon(
                    Icons.face,
                    size: 48,
                  )
                ),

              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {
                //Close drawer by defualt when routing to other pages.
                 Navigator.pop(context); 

                 // Navigator.pushNamed(context, SecondPage());
                },
              ),

              ListTile( //add onTap for Navigation
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                onTap: () {
                 Navigator.pop(context); 

                 // Navigator.pushNamed(context, SecondPage());
                },
              ),
              ],
            ),
          ),
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Application'),
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),

        ],
      ),


      ),
    );
  }
}

//bottom sheet is the button at bottom (sticky)