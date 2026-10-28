import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveApp());
}

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 3',
      home: const ResponsiveHomePage(),
    );
  }
}

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive UI'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 600;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Experiment 3',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  'Screen Width: ${screenWidth.toStringAsFixed(1)}',
                ),
                Text(
                  'Screen Height: ${screenHeight.toStringAsFixed(1)}',
                ),
                Text(
                  'Orientation: ${orientation == Orientation.portrait ? "Portrait" : "Landscape"}',
                ),

                const SizedBox(height: 25),

                if (isWide)
                  Row(
                    children: [
                      Expanded(child: _buildCard('BMI Calculator', Icons.monitor_weight)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildCard('Workout Tracker', Icons.fitness_center)),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildCard('BMI Calculator', Icons.monitor_weight),
                      const SizedBox(height: 16),
                      _buildCard('Workout Tracker', Icons.fitness_center),
                    ],
                  ),

                const SizedBox(height: 20),

                Text(
                  isWide
                      ? 'Wide layout: Row is used'
                      : 'Small layout: Column is used',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(String title, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, size: 55),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}