import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notee_reminder/state_management/counter_controller.dart';
import 'package:notee_reminder/state_management/page2.dart';

class Page1 extends ConsumerWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final counterProvider = ref.watch(counterController);

    return Scaffold(
      appBar: AppBar(
        title: Text("Page 1"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => Page2()));
            },
            icon: Icon(Icons.send),
          ),
        ],
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
