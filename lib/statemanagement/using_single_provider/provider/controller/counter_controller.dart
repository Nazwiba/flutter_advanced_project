import 'package:flutter/material.dart';
import '../model/count.dart';

class CounterProvider extends ChangeNotifier {
  //ChangeNotifier - notify the state to provider through notifylistener
// to increment
  Count _incCounter = Count(0);
  Count get counterValue => _incCounter;

  void incrementCount() {
    _incCounter.value++;
    notifyListeners(); // to know provider through notifylistener to the changenotifier and  view in ui
  }

// to decrement
  Count _decCounter = Count(0);
  Count get countValue => _decCounter;
  void decrementCount() {
    _decCounter.value--;
    notifyListeners();
  }
}
