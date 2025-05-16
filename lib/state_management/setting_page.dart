import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notee_reminder/state_management/profile_controller.dart';
import 'package:notee_reminder/state_management/setting_controller.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final settingProvider = ref.watch(settingController);
    final profileProvider = ref.watch(profileController);

    return Scaffold(
      appBar: AppBar(
        title: Text("setting"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              profileProvider.onSave(context);
            },
          )
        ],
      ),
      body: Form(
        key: profileProvider.formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: profileProvider.fullNameController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      } else if (value.length < 2) {
                        return 'Min length 2 chars';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(labelText: "full Name"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: profileProvider.emailController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "required";
                        } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value) ==
                            false) {
                          return 'invalid email';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: profileProvider.passwordController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      } else if (value.length < 8 || value.length > 20) {
                        return "password must be between 8 : 20 characters length";
                      } else {
                        return null;
                      }
                    },
                    obscureText: profileProvider.hidePassword,
                    decoration: InputDecoration(
                      labelText: "Passwords",
                      suffixIcon: GestureDetector(
                        child: Icon(profileProvider.hidePassword ? Icons.visibility_off : Icons.visibility),
                        onTap: () {
                          profileProvider.togglePasswordVisability();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: settingProvider.enableNightMode,
                    onChanged: (newValue) {
                      settingProvider.switchNightMode(newValue);
                    },
                    title: Text("Night Mode"),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: settingProvider.enableTwitter,
                    onChanged: (newValue) {
                      settingProvider.switchTwitter(newValue);
                    },
                    title: Text("Twitter"),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: settingProvider.enableNotifications,
                    onChanged: (newValue) {
                      settingProvider.switchNotifications(newValue);
                    },
                    title: Text("Notifications"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
