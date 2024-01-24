import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyScreen());
}

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // theme of your device
    var isdark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return MaterialApp(
      theme: isdark == true ? ThemeData.dark() : ThemeData.light(),
      home: Orientationss(),
    );
  }
}

class Orientationss extends StatelessWidget {
  var orientation;
  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: orientation == Orientation.portrait ? ListScreen() : GridScreen(),
    );
  }
}

class GridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grid Screen"),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: List.generate(
            20,
            (index) => Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.primaries[
                          Random().nextInt(Colors.primaries.length)]),
                  child: Center(
                    child: Text(
                      "Grid $index",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                )),
      ),
    );
  }
}

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Screen"),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://tse2.mm.bing.net/th?id=OIP.JDa_1X-NqdM1K-bZxp99DQHaEo&pid=Api&P=0&h=220"),
                    fit: BoxFit.cover)),
          ),
        );
      }),
    );
  }
}
