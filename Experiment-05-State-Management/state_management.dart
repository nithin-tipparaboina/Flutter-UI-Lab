import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: const StateManagementApp(),
    ),
  );
}

// Provider for managing shared state
class CounterProvider extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    count--;
    notifyListeners();
  }
}

// Main application using StatelessWidget
class StateManagementApp extends StatelessWidget {
  const StateManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'State Management Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// Home screen using StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int localCount = 0;

  @override
  Widget build(BuildContext context) {
    final providerCount = context.watch<CounterProvider>().count;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 5: State Management'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.widgets,
                size: 70,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),

              const Text(
                'StatelessWidget',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'This heading is displayed by a StatelessWidget.',
                textAlign: TextAlign.center,
              ),

              const Divider(height: 35),

              const Text(
                'StatefulWidget + setState()',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Local Count: $localCount',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    localCount++;
                  });
                },
                child: const Text('Increment with setState()'),
              ),

              const Divider(height: 35),

              const Text(
                'Provider State Management',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Provider Count: $providerCount',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<CounterProvider>().increment();
                    },
                    child: const Text('Increment Provider'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      context.read<CounterProvider>().decrement();
                    },
                    child: const Text('Decrement Provider'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}