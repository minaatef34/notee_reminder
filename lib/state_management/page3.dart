import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notee_reminder/state_management/counter_controller.dart';

class Page3 extends ConsumerWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final counterProvider = ref.watch(counterController);
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 3"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Text('counter: ${counterProvider.counter}'),
        ),
      ),
    );
  }
}
