import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notee_reminder/state_management/counter_controller.dart';
import 'package:notee_reminder/state_management/page3.dart';

class Page2 extends ConsumerWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final counterProvider = ref.watch(counterController);
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 2"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => Page3()));
            },
            icon: Icon(Icons.send),
          ),
          IconButton(
            onPressed: () {
             counterProvider.decreaseCounter();
            },
            icon: Icon(Icons.remove),
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

