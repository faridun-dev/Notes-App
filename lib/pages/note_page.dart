import 'package:flutter/material.dart';
import 'package:notes_app/consts/colors.dart';
import 'package:notes_app/utils/note_page_app_bar.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.notes[widget.index][0],
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
