import 'package:flutter/material.dart';
import 'package:notes_app/consts/colors.dart';
import 'package:notes_app/utils/add_button_util.dart';
import 'package:notes_app/utils/app_bar.dart';
import 'package:notes_app/utils/note_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [
    ["My plan of day", "Content of this note. Lol i am feeling lonely"],
    [
      "Just a test note",
      "Therefore i use my headphones 24/7 cuz music gives me a feeling of greatness"
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) => NoteCard(
          title: notes[index][0],
          content: notes[index][1],
        ),
      ),
      floatingActionButton: floatingButton,
    );
  }
}
