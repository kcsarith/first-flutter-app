import 'package:flutter/material.dart';

class AlgorithmForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AlgorithmFormState();
}

class _AlgorithmFormState extends State<AlgorithmForm> {
  int currentTab = 4;
  final double _formDistance = 5.0;
  List<String> result = [];
  TextEditingController arrayController = new TextEditingController(
      text: "Fish,Fish,Fish,Fish,Fish,Fish,Coal,Toy,Desk,Eggs,Clothes,Gold");
  TextEditingController sameCrateIdleController =
      new TextEditingController(text: "2");
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text("Loading Dock Problem"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            label: 'Namer',
            icon: Icon(Icons.title),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            label: 'Todo',
            icon: Icon(Icons.assignment_outlined),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            label: 'Fuel',
            icon: Icon(Icons.attach_money),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            label: 'Algo',
            icon: Icon(Icons.code_sharp),
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: (int index) {
          setState(() => currentTab = index);
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
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
              break;
            default:
              return null;
          }
        },
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),

              child:
              TextField(
                controller: arrayController,
                decoration: InputDecoration(
                  labelStyle: textStyle,
                  labelText: 'Seperate list by commas, no quotes',
                  hintText: 'test1, test2, test3, test 1',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: TextField(
                controller: sameCrateIdleController,
                decoration: InputDecoration(
                  labelStyle: textStyle,
                  labelText: 'Time needed to idle on same crates',
                  hintText: 'eg: 1, 2, 3 etc...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex:2,
                  child: ElevatedButton(
                    child: Text('Submit', textScaleFactor: 1.5),
                    onPressed: () {
                      setState(() {
                        result = _createList();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                ),
                Expanded(
                  child: ElevatedButton(
                    child: Text('Reset', textScaleFactor: 1.5),
                    onPressed: () {
                      setState(() {
                        _reset();
                      });
                    },
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                  'Minimum work to complete task is ' +
                      result.length.toString() +
                      ' moves.'),
            ),
            Text(result.toString()),
          ],
        ),
      ),
    );
  }

  List<String> _createList() {
    final List<String> resultsArray = [];
    final memo = {};
    final crateQueue = [];

    List<String> arrayOfCrates = arrayController.text.toString().split(',');
    int sameCrateRestTime = int.parse(sameCrateIdleController.text);

    for (int i = 0; i < arrayOfCrates.length; i++) {
      final currentCrate = arrayOfCrates[i];
      if (memo[currentCrate] == null) {
        memo[currentCrate] = {"count": 1, "nextIndex": 0};
      } else {
        memo[currentCrate]["count"] += 1;
      }
    }
    var counterArrayKeys = memo.keys.toList();
    var counterArrayValues = memo.values.toList();
    var counterArray = [];
    for (int i = 0; i < counterArrayKeys.length; i++) {
      var key = counterArrayKeys[i];
      var value = counterArrayValues[i];
      counterArray.add([key, value]);
    }
    counterArray
        .sort((ele2, ele1) => ele1[1]["count"].compareTo(ele2[1]["count"]));
    // sortByKey(counterArray, 'count');
    print('Crate List Array');
    print(counterArray);
    int counterIndex = 0;
    while (counterArray.length > 0 || crateQueue.length > 0) {
      if (crateQueue.asMap().containsKey(0)) {
        if (resultsArray.length > crateQueue[0][1]["nextIndex"] - 1) {
          if (counterArray.asMap().containsKey(counterIndex)) {
            if (crateQueue[0][0] != counterArray[counterIndex][0]) {
              counterIndex = 0;
            }
          } else {
            counterIndex = 0;
          }
          final dequeueCrate = crateQueue.removeAt(0);
          print('DEQUEUE ');
          print(dequeueCrate);
        } else {}
        print('Exists');
      }
      if (counterArray.asMap().containsKey(counterIndex)) {
        counterArray[counterIndex][1]["count"] -= 1;
        counterArray[counterIndex][1]["nextIndex"] =
            resultsArray.length + sameCrateRestTime + 1;
        resultsArray.add(counterArray[counterIndex][0]);
        print('Results Array Length: ' + resultsArray.length.toString());
        print(resultsArray);
        if (counterArray[counterIndex][1]["count"] <= 0) {
          // counterArray.splice(counterIndex, 1);
          counterArray.removeAt(counterIndex);
        } else {
          crateQueue.add(counterArray[counterIndex]);
          print('ENQUEUE ');
          print(counterArray[counterIndex]);
          print('QUEUE ');
          print(crateQueue);
          counterIndex++;
        }
      } else {
        final iterationsNeeded =
            crateQueue[0][1]["nextIndex"] - resultsArray.length;

        for (int i = 0; i < iterationsNeeded; i++) {
          resultsArray.add('*------*');
        }
        counterIndex = 0;
      }
    }
    print('FINAL RESULT ARRAY');
    print(resultsArray);
    return resultsArray;
  }

  void _reset() {
    arrayController.text = '';
    sameCrateIdleController.text = '';
    setState(() {
      result = [];
    });
  }
}
