import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notee_reminder/state_management/counter_controller.dart';
import 'package:notee_reminder/state_management/page1.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final counterProvider = ref.watch(counterController);

    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Page"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => Page1()));
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(counterProvider.counter.toString()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  heroTag: 'add',
                  onPressed: () {
                    counterProvider.increaseCounter();
                  },
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                  heroTag: 'remove',
                  onPressed: () {
                    counterProvider.decreaseCounter();
                  },
                  child: Icon(Icons.remove),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
