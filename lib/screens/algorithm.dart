import 'package:flutter/material.dart';

class AlgorithmForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AlgorithmFormState();
}

class _AlgorithmFormState extends State<AlgorithmForm> {
  String result = '';
  String _currency = 'Dollars';

  int currentTab = 4;
  final double _formDistance = 5.0;
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  TextEditingController distanceController = new TextEditingController();
  TextEditingController avgController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
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
        } ,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: TextField(
                controller: distanceController,
                decoration: InputDecoration(
                  labelStyle: textStyle,
                  labelText: 'Distance',
                  hintText: 'e.g 124',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: TextField(
                controller: avgController,
                decoration: InputDecoration(
                  labelStyle: textStyle,
                  labelText: 'Distance per Unit',
                  hintText: 'e.g 17',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(child:
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelStyle: textStyle,
                      labelText: 'Price',
                      hintText: 'e.g 1.65',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  ),
                  Container(width: _formDistance*5),
                  Expanded(child:
                  DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currency,
                      onChanged: (String value) {
                        _onDropdownChanged(value);
                      }),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(child:
                ElevatedButton(
                  child: Text('Submit', textScaleFactor: 1.5),
                  onPressed: () {
                    setState(() {
                      result = _calculate();
                    });
                  },
                ),
                ),
                Expanded(child:
                ElevatedButton(
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

            Text(result),
          ],
        ),
      ),
    );
  }

  _onDropdownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _avg = double.parse(avgController.text);
    double _price = double.parse(priceController.text);
    double _total = (_distance / _avg) * _price;
    String _result = 'The total price of your trip is ' +
        _total.toStringAsFixed(2) +
        ' ' +
        _currency;
    return _result;
  }
  void _reset(){
    distanceController.text ='';
    avgController.text='';
    priceController.text='';
    setState(() {
      result = '';
    });
  }
}