import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:testappflutter/models/note_model.dart';
import 'package:testappflutter/screens/inputScreen.dart';
import 'database/database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: TestApp(),
    );
  }
}

class TestApp extends StatefulWidget {
  @override
  _TestApp createState() => _TestApp();
}

class _TestApp extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter SQLite")),
      body: FutureBuilder<List<Note>>(
        future: DBProvider.db.getAllNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Note item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.blue),
                  onDismissed: (direction) {
                    DBProvider.db.deleteNote(item.id);
                  },
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InputScreen(
                          note: item,
                        ),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              letterSpacing: 0.8,
                            ),
                          ),
                          Divider(
                            height: 10.0,
                          ),
                          Text(
                            item.data,
                            style: TextStyle(
                              letterSpacing: 0.6,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => InputScreen(
                note: Note(id: -1, title: '', data: ''),
              ),
            ),
          );
        },
      ),
    );
  }
}
