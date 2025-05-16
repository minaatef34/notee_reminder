import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notee_reminder/state_management/profile_controller.dart';
import 'package:notee_reminder/state_management/setting_controller.dart';

class ReviewPage extends ConsumerWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final settingProvider = ref.watch(settingController);
    final profileProvider = ref.watch(profileController);

    return Scaffold(
      appBar: AppBar(
        title: Text("review"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 15,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Full Name"),
                Text(profileProvider.fullNameController.text),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Email"),
                Text(profileProvider.emailController.text),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Passwords"),
                Text(profileProvider.passwordController.text),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Night Mode"),
                Text(settingProvider.enableNightMode.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Twitter"),
                Text(settingProvider.enableTwitter.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Notification"),
                Text(settingProvider.enableNotifications.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
