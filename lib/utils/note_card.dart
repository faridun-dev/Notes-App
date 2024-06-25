import 'package:flutter/material.dart';
import 'package:notes_app/consts/colors.dart';

class NoteCard extends StatefulWidget {
  final title;
  final content;

  const NoteCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: foregroundColor,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        padding: const EdgeInsets.all(
          30,
        ),
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: fontColor,
                fontSize: 25.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
