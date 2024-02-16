import 'package:get/get.dart';

class CountController extends GetxController {
  var count = 0.obs;
  //RxInt count1 = 0.obs;
  //RxInt count2 = RxInt(0);

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }
}
