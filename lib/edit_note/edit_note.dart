import 'package:flutter/material.dart';
import 'package:notee_reminder/home/presentation/pages/home_page.dart';
import 'package:notee_reminder/controller/sqldb.dart';

class EditNote extends StatefulWidget {
  final note;
  final title;
  final id;

  const EditNote({super.key, this.note, this.title, this.id});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    super.initState();
  }

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
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          int response = await sqlDb.updateData(
            ''' UPDATE notes SET 
                `note` = "${note.text}" , 
                `title` = "${title.text}" 
                 WHERE `id` = ${widget.id}
                  ''',
          );
          if (response > 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
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
