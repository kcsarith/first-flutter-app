import 'package:flutter/material.dart';
import 'package:startup_namer/model/todo.dart';
import 'package:startup_namer/util/dbhelper.dart';
import 'package:startup_namer/screens/todoDetail.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();

}

class TodoListState extends State {
  DbHelper helper = DbHelper();
  List<Todo> todos;
  int count = 0;
  int currentTab = 2;

  @override
  Widget build(BuildContext context) {
    if (todos == null) {
      todos = List<Todo>();
      getData();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
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
      body: todoListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          navigateToDetail(Todo('',3,''));
        }
        ,
        tooltip: "Add new Todo",
        child: new Icon(Icons.add),
      ),
    );
  }
  ListView todoListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(this.todos[position].priority),
              child:Text(this.todos[position].priority.toString()),
            ),
            title: Text(this.todos[position].title),
            subtitle: Text(this.todos[position].date),
            onTap: () {
              debugPrint("Tapped on " + this.todos[position].id.toString());
              navigateToDetail(this.todos[position]);
            },
          ),
        );
      },
    );
  }
  void getData() {
    final dbFuture = helper.initializeDb();
    dbFuture.then((result) {
      final todosFuture = helper.getTodos();
      todosFuture.then((result){
        List<Todo> todoList = List<Todo>();
        count = result.length;
        for (int i=0; i<count; i++) {
          todoList.add(Todo.fromObject(result[i]));
          debugPrint(todoList[i].title);
        }
        setState(() {
          todos = todoList;
          count = count;
        });
        debugPrint("Items " + count.toString());
      });
    });
  }

  Color getColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.green;
        break;

      default:
        return Colors.green;
    }
  }

  void navigateToDetail(Todo todo) async {
    bool result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => TodoDetail(todo)),
    );
    if (result == true) {
      getData();
    }
  }

}