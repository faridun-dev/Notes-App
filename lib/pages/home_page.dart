import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/consts/colors.dart';
import 'package:notes_app/data/database.dart';
import 'package:notes_app/pages/note_page.dart';
import 'package:notes_app/utils/app_bar.dart';
import 'package:notes_app/utils/note_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = Database();
  final _dataBox = Hive.box("notes");
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void deleteNote(int index) {
    setState(() {
      db.notes.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  void initState() {
    if (_dataBox.get("NOTES") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: ListView.builder(
        itemCount: db.notes.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(db.notes[index]),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            deleteNote(index);
          },
          background: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 20,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: deleteContainerColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    12,
                  ),
                ),
              ),
              child: const Icon(
                Icons.delete,
                color: deleteIconColor,
              ),
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotePage(
                    notes: db.notes,
                    index: index,
                  ),
                ),
              );
            },
            child: NoteCard(
              title: db.notes[index][0],
              content: db.notes[index][1],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: foregroundColor,
        foregroundColor: fontColor,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  backgroundColor: backgroundColor,
                  appBar: AppBar(
                    title: const Text(
                      "Add new note",
                    ),
                    elevation: 3,
                    centerTitle: true,
                    titleTextStyle: const TextStyle(
                      color: fontColor,
                      fontSize: 25.0,
                    ),
                    backgroundColor: foregroundColor,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: "Title",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: contentController,
                          decoration: const InputDecoration(
                            labelText: "Content",
                            border: OutlineInputBorder(),
                          ),
                          minLines: 3,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: foregroundColor,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  final titleText = titleController.text;
                                  final contentText = contentController.text;
                                  db.notes.add([titleText, contentText]);
                                  titleController.clear();
                                  contentController.clear();
                                });
                                db.updateDataBase();
                                Navigator.of(context).pop();
                              },
                              child: const Text("Add note"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
