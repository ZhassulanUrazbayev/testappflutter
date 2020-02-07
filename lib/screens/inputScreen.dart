import 'package:flutter/material.dart';
import 'package:testappflutter/database/database.dart';
import 'package:testappflutter/main.dart';
import 'package:testappflutter/models/note_model.dart';

class InputScreen extends StatefulWidget {
  final Note note;

  InputScreen({this.note});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final titleController = TextEditingController();

  final dataController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    titleController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: widget.note.title))
        .value;

    dataController.value = new TextEditingController.fromValue(
            new TextEditingValue(text: widget.note.data))
        .value;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                if(widget.note.id != -1){
                await DBProvider.db.updateClient(Note(id: widget.note.id,
                    title: titleController.text, data: dataController.text));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyApp(),
                  ),
                );
              }else{
                  await DBProvider.db.newClient(Note(
                      title: titleController.text, data: dataController.text));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MyApp(),
                    ),
                  );
                }
              } )
        ],
        title: Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: dataController,
            ),
          ],
        ),
      ),
    );
  }
}
