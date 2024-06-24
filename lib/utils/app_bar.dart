import 'package:flutter/material.dart';
import 'package:notes_app/consts/colors.dart';

final AppBar appBar = AppBar(
  title: const Text("Notes"),
  elevation: 3,
  centerTitle: true,
  titleTextStyle: const TextStyle(
    color: fontColor,
    fontSize: 25.0,
  ),
  backgroundColor: foregroundColor,
);
