import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/statemanagement/using_getx/controller.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    home: GetMain(),
  ));
}

class GetMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CountController controller =
        Get.put(CountController()); // to register counter page into main page
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text("Count = ${controller.count}")),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () => controller.increment(),
                child: const Text("Increment")),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () => controller.decrement(),
                child: const Text("Decrement"))
          ],
        ),
      ),
    );
  }
}
