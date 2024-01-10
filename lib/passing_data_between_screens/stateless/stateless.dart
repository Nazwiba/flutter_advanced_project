import 'package:flutter/material.dart';

class ScreenStateless extends StatelessWidget {
  String? name; // data received from the constructor
  String? place;
  String? course;
  ScreenStateless(
      {super.key,
      required this.name,
      required this.place,
      required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome To $name located at $place Course name is $course",
          style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
