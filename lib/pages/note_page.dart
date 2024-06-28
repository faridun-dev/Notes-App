import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/consts/colors.dart';
import 'package:notes_app/data/database.dart';

class NotePage extends StatefulWidget {
  final List notes;
  final int index;

  const NotePage({
    super.key,
    required this.notes,
    required this.index,
  });

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _formKey = GlobalKey<FormState>();
  final db = Database();
  final _dataBox = Hive.box("notes");

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
    String? title = db.notes[widget.index][0];
    String? content = db.notes[widget.index][1];
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.notes[widget.index][0],
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      backgroundColor: backgroundColor,
                      appBar: AppBar(
                        title: const Text(
                          "Edit note",
                        ),
                        centerTitle: true,
                        titleTextStyle: const TextStyle(
                          color: fontColor,
                          fontSize: 25.0,
                        ),
                        leading: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: foregroundColor,
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                maxLines: null,
                                onSaved: (String? value) {
                                  title = value;
                                },
                                initialValue: db.notes[widget.index][0],
                                decoration: const InputDecoration(
                                  labelText: "Title",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                maxLines: null,
                                onSaved: (String? value) {
                                  content = value;
                                },
                                initialValue: db.notes[widget.index][1],
                                decoration: const InputDecoration(
                                  labelText: "Content",
                                  border: OutlineInputBorder(),
                                ),
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
                                      _formKey.currentState!.save();
                                      setState(() {
                                        db.notes[widget.index][0] = title;
                                        db.notes[widget.index][1] = content;
                                      });
                                      db.updateDataBase();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Save changes"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
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
            Text(
              widget.notes[widget.index][1],
              style: const TextStyle(
                color: fontColor,
                fontSize: 20.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
