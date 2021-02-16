import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/screens/introduction.dart';
import 'package:startup_namer/screens/randomWords.dart';
import 'package:startup_namer/screens/fuelForm.dart';
import 'package:startup_namer/screens/todoList.dart';
import 'package:startup_namer/screens/algorithm.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        initialRoute: '/',
        routes: {
          '/': (context)=>MyHomePage(),
          '/random_words': (context)=>RandomWords(),
          '/todo': (context)=>TodoList(),
          '/fuel': (context)=>FuelForm(),
          '/algo': (context)=>AlgorithmForm(),
        },
        // home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home), backgroundColor: Colors.blue,),
          BottomNavigationBarItem(label: 'Namer', icon: Icon(Icons.title), backgroundColor: Colors.blue,),
          BottomNavigationBarItem(label: 'Todo', icon: Icon(Icons.assignment_outlined), backgroundColor: Colors.blue,),
          BottomNavigationBarItem(label: 'Fuel', icon: Icon(Icons.attach_money), backgroundColor: Colors.blue,),
          BottomNavigationBarItem(label: 'Algo', icon: Icon(Icons.code_sharp), backgroundColor: Colors.blue,),
        ],
        onTap: (int index){
          setState(() => currentTab = index);
            switch (index){
              case 0:
                break;
              case 1:
                Navigator.pushNamed(context, '/random_words');
                break;
              case 2:
                Navigator.pushNamed(context, '/todo');
                break;
              case 3:
                Navigator.pushNamed(context, '/fuel');
                break;
              case 4:
                Navigator.pushNamed(context, '/algo');
                break;
              default:
                return null;
            }
        } ,
      ),
      body: Introduction(),
    );
  }
}
