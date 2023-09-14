import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'todo.dart';

class TodoCreate extends StatefulWidget {
  final DatabaseReference reference;
  TodoCreate(this.reference);

  @override
  State<TodoCreate> createState() => _TodoCreate();
}

class _TodoCreate extends State<TodoCreate> {
  TextEditingController? titleController = TextEditingController();
  TextEditingController? contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('할 일 작성')),
      body: Container(
        child: Center(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: '제목'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: '할일'),
              ),
            ),
            ElevatedButton(
              child: Text('저장'),
              onPressed: () {
                widget.reference
                    .push()
                    .set(Todo(
                            titleController!.value.text,
                            contentController!.value.text,
                            DateTime.now().toIso8601String())
                        .toJson())
                    .then((_) {
                  Navigator.of(context).pop();
                });
              },
            )
          ],
        )),
      ),
    );
  }
}
