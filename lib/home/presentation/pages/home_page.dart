import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notee_reminder/add_note/add_note_page.dart';
import 'package:notee_reminder/shared_widget/card_color.dart';
import 'package:notee_reminder/edit_note/edit_note.dart';
import 'package:notee_reminder/controller/sqldb.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];
  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  Color getRandomColor() {
    Random random = Random();
    return cardColor[random.nextInt(cardColor.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notes",
                style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  hintText: "Search Notes....",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  fillColor: Colors.grey.shade800,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: notes.length,
                      padding: EdgeInsets.only(top:30),
                      itemBuilder: (context, i) {
                        return Card(
                          margin: EdgeInsets.only(bottom: 20),
                          color: getRandomColor(),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                             contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              title: Text("${notes[i]["note"]}",
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18, height: 1.5)),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  ("${notes[i]["title"]}"),
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.grey),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        int response =
                                            await sqlDb.deleteData("DELETE FROM notes WHERE id = ${notes[i]['id']}");
                                        if (response > 0) {
                                          notes.removeWhere((element) => element['id'] == notes[i]['id']);
                                          setState(() {});
                                        }
                                      },
                                      icon: Icon(Icons.delete,)),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditNote(
                                              note: notes[i]["note"],
                                              title: notes[i]["title"],
                                              yourNote: notes[i]["yourNote"],
                                              id: notes[i]["id"],
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.edit)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage()));
        },
        backgroundColor: Colors.grey.shade700,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
