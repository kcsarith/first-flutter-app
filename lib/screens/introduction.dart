import 'package:flutter/material.dart';
import 'package:startup_namer/util/globals.dart' as globals;

class Introduction extends StatefulWidget {
  Introduction({Key key, this.title}) : super(key: key);
  final String title;

  @override
  IntroductionState createState() => IntroductionState();
}

class IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                "Krisna's App",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'You have this many likes so far ',
                )),
            Text(
              globals.savedSuggestions.length.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Also contains a Todo List, Fuel Calculator and the Algorithm.',
                )),
          ],
        ),
      ),
    );
  }
}
