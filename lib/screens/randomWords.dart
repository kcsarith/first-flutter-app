import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'package:startup_namer/util/globals.dart' as globals;

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState()=> RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  // final List<WordPair> suggestions = globals.suggestions;
  final TextStyle _biggerFont = const TextStyle(fontSize:18);
  int currentTab = 1;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions:[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
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
      body: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i) {
        if(i.isEven){
          return Divider();
        }
        final int index = i~/2;

        if (index >= globals.suggestions.length){
          globals.suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(globals.suggestions[index]);
      },
    );
  }
  Widget _buildRow(WordPair pair){
    final alreadySaved = globals.savedSuggestions.contains(pair);
    return ListTile(
      title: Text(
          pair.asPascalCase,
          style:_biggerFont
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            globals.savedSuggestions.remove(pair);
          }else{
            globals.savedSuggestions.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder:(BuildContext context){
              final tiles = globals.savedSuggestions.map((pair) {
                return ListTile(title: Text(pair.asPascalCase, style: _biggerFont));
              });
              final divided = ListTile.divideTiles(
                context: context,
                tiles: tiles,
              ).toList();
              return Scaffold(
                appBar: AppBar(
                  title: Text('Saved Suggestions'),
                ),
                body: ListView(children: divided),

              );
            }
        )
    );
  }



}