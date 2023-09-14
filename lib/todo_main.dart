import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'todo_create.dart';
import 'todo.dart';

class TodoMain extends StatefulWidget {
  const TodoMain({super.key, required this.title});
  final String title;

  @override
  State<TodoMain> createState() => _TodoMain();
}

class _TodoMain extends State<TodoMain> {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String _databaseURL =
      'https://flutterexample-6b048-default-rtdb.firebaseio.com/';
  List<Todo> todoList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('todo');
    reference!.onChildAdded.listen((event) {
      setState(() {
        todoList.add(Todo.fromSnapshot(event.snapshot));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: Center(
          child: todoList.isEmpty
              ? const CircularProgressIndicator()
              : ListView.separated(
                  itemCount: todoList.length,
                  separatorBuilder: (context, index) {
                    return const Divider(color: Colors.blueGrey, height: 2);
                  },
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(todoList[index].title,
                          style: const TextStyle(fontSize: 20)),
                      subtitle: Column(
                        children: <Widget>[
                          Text(todoList[index].content),
                          Text(todoList[index].createTime)
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/detail', arguments: todoList[index]);
                      },
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TodoCreate(reference!)));
        },
      ),
    );
  }
}
