import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  //if state is null then change the value to 1 otherwise add 1 to it.
  void increment() => state = (state == null) ? 1 : state! + 1;
}

final counterProvider = StateNotifierProvider<Counter, int?>(
  (ref) => Counter(),
);

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //adding ref.watch here is a bit risky as it rebuilds the entire widget.
    return Scaffold(
      //Consumer builder is a better option here
      body: Center(child: Consumer(builder: (context, ref, child) {
        final counter = ref.watch(counterProvider);
        final text = counter ?? 0;
        return Text(text.toString());
      })),
      floatingActionButton: TextButton(
          onPressed: ref.read(counterProvider.notifier).increment,
          child: const Icon(Icons.add)),
    );
  }
}
