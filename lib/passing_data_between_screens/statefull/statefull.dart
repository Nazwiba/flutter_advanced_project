import 'package:flutter/material.dart';

class ScreenStatefull extends StatefulWidget {
  String? name;
  String? place;
  String course;
  ScreenStatefull(
      {super.key,
      this.name,
      this.place,
      required this.course});

  @override
  State<ScreenStatefull> createState() => _ScreenStatefullState();
}

class _ScreenStatefullState extends State<ScreenStatefull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
        Text("Welcome to ${widget.name} located at ${widget.place} Course name is ${widget.course}"),
      ),
    );
  }
}
