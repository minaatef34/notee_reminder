import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notee_reminder/state_management/review_page.dart';

final profileController = ChangeNotifierProvider<ProfileController>((ref) => ProfileController());

class ProfileController extends ChangeNotifier {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool hidePassword = true;

  void togglePasswordVisability() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  void onSave(BuildContext context) {
    hideKeyboard();
    validateInputs(context);
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void validateInputs(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewPage()));
    }
  }
}
