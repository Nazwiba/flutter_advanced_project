import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MainPageMedia(),
  ));
}

class MainPageMedia extends StatelessWidget {
  bool? isLargeScreen;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
     isLargeScreen = width > 600;
    return Scaffold(
      body: 
      //width > 600 ? BigScreen() : MobileScreen(),
      isLargeScreen == true ? BigScreen() : MobileScreen(),
    );
  }
}

class MobileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Mobile Screen"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 300,
              decoration: const BoxDecoration(color: Colors.greenAccent),
            ),
          ),
          Expanded(child: ListView.builder(itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: Colors.pink.shade100,
                child: Text("Video $index"),
              ),
            );
          }))
        ],
      ),
    );
  }
}

class BigScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Big Screen"),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 300,
                    decoration: const BoxDecoration(color: Colors.greenAccent),
                  ),
                ),
                Expanded(child: ListView.builder(itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      color: Colors.pink.shade100,
                      child: Text("Video $index"),
                    ),
                  );
                }))
              ],
            ),
          ),
          Expanded(child: ListView.builder(itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: Colors.orange.shade400,
                child: Text("Video $index"),
              ),
            );
          }))
        ],
      ),
    );
  }
}
