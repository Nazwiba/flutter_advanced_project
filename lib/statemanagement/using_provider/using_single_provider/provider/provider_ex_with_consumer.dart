import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/statemanagement/using_provider/using_single_provider/provider/controller/counter_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => CounterProvider(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider with Consumer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Counter value:",
              style: TextStyle(fontSize: 18),
            ),
            Consumer<CounterProvider>(
                builder: (context, counterProvider, child) {
              return Text(
                "${counterProvider.counterValue}",
                style: const TextStyle(fontSize: 24, 
                fontWeight: FontWeight.bold),
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CounterProvider>(context, listen: false).incrementCount();
        },
        tooltip: "Increment",
        child: const Icon(Icons.add),
      ),
    );
  }
}
