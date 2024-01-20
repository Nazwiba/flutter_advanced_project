import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/statemanagement/using_single_provider/provider/controller/counter_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: ChangeNotifierProvider(
        create: (context) => CounterProvider(), child: CounterProviderEx()),
  ));
}

class CounterProviderEx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counterController = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider Ex"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Increment Counter",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 15,
            ),
             Text("Counter Increment value: ${counterController.counterValue.value}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
             Text("Counter decrement  value: ${counterController.countValue.value}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                counterController.incrementCount();
              },
              child: const Text("Increment value"),
            ),
            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: () {
                counterController.decrementCount();
              },
              child: const Text("decrement value"),
            )
          ],
        ),
      ),
    );
  }
}
