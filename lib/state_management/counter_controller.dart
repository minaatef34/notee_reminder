import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterController = ChangeNotifierProvider<CounterController>((ref) => CounterController());

class CounterController extends ChangeNotifier {
  int counter = 0;

  void increaseCounter() {
    counter++;
    notifyListeners();
  }

  void decreaseCounter() {
    counter--;
    notifyListeners();
  }
}
