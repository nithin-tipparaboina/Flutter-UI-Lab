import 'package:flutter/material.dart';

void main() {
  runApp(const TestingDemoApp());
}

class TestingDemoApp extends StatelessWidget {
  const TestingDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Testing and Debugging'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Button pressed:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              '$counter',
              key: const Key('counterValue'),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('incrementButton'),
              onPressed: incrementCounter,
              child: const Text('Increment'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              key: const Key('resetButton'),
              onPressed: resetCounter,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}