import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/passing_data_between_screens/statefull/statefull.dart';
import 'package:flutter_advanced_project/passing_data_between_screens/stateless/stateless.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DataHome(),
  ));
}

class DataHome extends StatelessWidget {
  String name = "Luminar";
  String place = "Ernakulam";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Passing"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScreenStateless(
                              name: name, place: place, course: "Flutter")));
                },
                child: const Text("to stateless Screen")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScreenStatefull(
                              name: name, place: place, course: "Flutter")));
                }, 
                child: const Text("to statefull Screen"))
          ],
        ),
      ),
    );
  }
}
