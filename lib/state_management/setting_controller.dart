import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingController = ChangeNotifierProvider<SettingController>((ref) => SettingController());

class SettingController extends ChangeNotifier {
  bool enableNightMode = false;
  bool enableTwitter = false;
  bool enableNotifications = false;

  void switchNightMode(bool newValue) {
    enableNightMode = newValue;
    notifyListeners();
  }

  void switchTwitter(bool newValue){
    enableTwitter = newValue;
    notifyListeners();
  }

  void switchNotifications (bool newValue){
    enableNotifications = newValue;
    notifyListeners();
  }
}
