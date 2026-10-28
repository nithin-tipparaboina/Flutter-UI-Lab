import 'package:flutter/material.dart';

void main() {
  runApp(const WidgetsDemoApp());
}

class WidgetsDemoApp extends StatelessWidget {
  const WidgetsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 2',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Widgets & Layouts'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Experiment 2',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Demonstration of basic Flutter widgets and layouts.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

             
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(),
                ),
                child: const Text(
                  'Container Widget',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),

              const SizedBox(height: 20),

              
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.home, size: 40),
                  Icon(Icons.favorite, size: 40),
                  Icon(Icons.star, size: 40),
                ],
              ),

              const SizedBox(height: 20),

             
              SizedBox(
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2),
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fitness_center, size: 50),
                        SizedBox(height: 8),
                        Text(
                          'FitTrack',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}