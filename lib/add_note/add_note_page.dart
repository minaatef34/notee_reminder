import 'package:flutter/material.dart';
import 'package:notee_reminder/home/presentation/pages/home_page.dart';
import 'package:notee_reminder/controller/sqldb.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController yourNote = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.all(0),
                    icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )))
              ],
            ),
            Container(
              child: Expanded(
                child: ListView(
                  children: [
                    Form(
                      key: formstate,
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Title",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 30,
                              ),
                            ),
                            validator: (input) {
                              if (input == null || input.isEmpty == true) {
                                return 'required';
                              }
                            },
                            controller: note,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type something here",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            controller: title,
                            validator: (input) {
                              if (input == null || input.isEmpty == true) {
                                return 'required';
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (formstate.currentState?.validate() == true) {
            int response = await sqlDb.insertData('''INSERT INTO notes (`note` , `title`, `yourNote`)
                  VALUES ("${note.text}" , "${title.text}", "${yourNote.text}")
                  ''');
            if (response > 0) {
              Navigator.pop(context);
            }
          }
        },
        backgroundColor: Colors.grey,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Icon(
          Icons.save,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
