import 'package:flutter/material.dart';

void main() {
  runApp(const FitTrackApp());
}

class FitTrackApp extends StatelessWidget {
  const FitTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTrack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const FitTrackHome(),
    );
  }
}

class FitTrackHome extends StatefulWidget {
  const FitTrackHome({super.key});

  @override
  State<FitTrackHome> createState() => _FitTrackHomeState();
}

class _FitTrackHomeState extends State<FitTrackHome> {
  int selectedModule = 0;

  final modules = const [
    BmiModule(),
    CalorieModule(),
    WorkoutModule(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FitTrack',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 600;
            final padding = MediaQuery.of(context).size.width < 400 ? 14.0 : 20.0;

            return Column(
              children: [
                const SizedBox(height: 12),
                _ModuleSelector(
                  selected: selectedModule,
                  isWide: isWide,
                  onSelected: (index) {
                    setState(() => selectedModule = index);
                  },
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: modules[selectedModule],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ModuleSelector extends StatelessWidget {
  final int selected;
  final bool isWide;
  final ValueChanged<int> onSelected;

  const _ModuleSelector({
    required this.selected,
    required this.isWide,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      ('BMI', Icons.monitor_weight),
      ('Calories', Icons.local_fire_department),
      ('Workout', Icons.fitness_center),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i == items.length - 1 ? 0 : 8),
                child: ElevatedButton.icon(
                  onPressed: () => onSelected(i),
                  icon: Icon(items[i].$2),
                  label: Text(isWide ? items[i].$1 : items[i].$1),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: selected == i
                        ? Theme.of(context).colorScheme.primaryContainer
                        : null,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}



class BmiModule extends StatefulWidget {
  const BmiModule({super.key});

  @override
  State<BmiModule> createState() => _BmiModuleState();
}

class _BmiModuleState extends State<BmiModule> {
  final weightController = TextEditingController(text: '54');
  final heightController = TextEditingController(text: '162');

  double? bmi;

  double calculateBmi(double weight, double heightCm) {
    final heightM = heightCm / 100;
    return weight / (heightM * heightM);
  }

  String getCategory(double value) {
    if (value < 18.5) return 'Underweight';
    if (value < 25) return 'Healthy range';
    if (value < 30) return 'Overweight';
    return 'Obese range';
  }

  void calculate() {
    final weight = double.tryParse(weightController.text);
    final height = double.tryParse(heightController.text);

    if (weight == null || height == null || weight <= 0 || height <= 0) {
      setState(() => bmi = null);
      return;
    }

    setState(() {
      bmi = calculateBmi(weight, height);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const _ModuleHeader(
          icon: Icons.monitor_weight,
          title: 'BMI Calculator',
          description: 'Calculate your Body Mass Index.',
        ),
        const SizedBox(height: 16),
        _InputCard(
          children: [
            TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                prefixIcon: Icon(Icons.monitor_weight),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: heightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                prefixIcon: Icon(Icons.height),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: calculate,
                icon: const Icon(Icons.calculate),
                label: const Text('Calculate BMI'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (bmi != null)
          _ResultCard(
            title: 'Your BMI',
            value: bmi!.toStringAsFixed(1),
            subtitle: getCategory(bmi!),
            icon: Icons.analytics,
          ),
      ],
    );
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }
}


class CalorieModule extends StatefulWidget {
  const CalorieModule({super.key});

  @override
  State<CalorieModule> createState() => _CalorieModuleState();
}

class _CalorieModuleState extends State<CalorieModule> {
  final ageController = TextEditingController(text: '20');
  final weightController = TextEditingController(text: '54');
  final heightController = TextEditingController(text: '162');

  String activity = 'Moderate';
  int? calories;

  double activityMultiplier(String level) {
    if (level == 'Low') return 1.2;
    if (level == 'High') return 1.725;
    return 1.55;
  }

  int calculateCalories(double weight, double height, int age) {
    final bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    return (bmr * activityMultiplier(activity)).round();
  }

  void calculate() {
    final age = int.tryParse(ageController.text);
    final weight = double.tryParse(weightController.text);
    final height = double.tryParse(heightController.text);

    if (age == null || weight == null || height == null ||
        age <= 0 || weight <= 0 || height <= 0) {
      setState(() => calories = null);
      return;
    }

    setState(() {
      calories = calculateCalories(weight, height, age);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const _ModuleHeader(
          icon: Icons.local_fire_department,
          title: 'Calorie Calculator',
          description: 'Estimate your daily calorie requirement.',
        ),
        const SizedBox(height: 16),
        _InputCard(
          children: [
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                prefixIcon: Icon(Icons.cake),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                prefixIcon: Icon(Icons.monitor_weight),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: heightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                prefixIcon: Icon(Icons.height),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: activity,
              decoration: const InputDecoration(
                labelText: 'Activity Level',
                prefixIcon: Icon(Icons.directions_run),
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Low', child: Text('Low')),
                DropdownMenuItem(value: 'Moderate', child: Text('Moderate')),
                DropdownMenuItem(value: 'High', child: Text('High')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => activity = value);
                }
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: calculate,
                icon: const Icon(Icons.calculate),
                label: const Text('Calculate Calories'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (calories != null)
          _ResultCard(
            title: 'Estimated Daily Calories',
            value: '$calories kcal',
            subtitle: '$activity activity level',
            icon: Icons.local_fire_department,
          ),
      ],
    );
  }

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }
}



class WorkoutModule extends StatefulWidget {
  const WorkoutModule({super.key});

  @override
  State<WorkoutModule> createState() => _WorkoutModuleState();
}

class _WorkoutModuleState extends State<WorkoutModule> {
  final workouts = <String, bool>{
    'Strength Training': false,
    'Cardio': false,
    'Leg Workout': false,
    'Core Workout': false,
  };

  int get completedCount => workouts.values.where((done) => done).length;

  @override
  Widget build(BuildContext context) {
    final progress = completedCount / workouts.length;
    final orientation = MediaQuery.of(context).orientation;

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const _ModuleHeader(
          icon: Icons.fitness_center,
          title: 'Workout Tracker',
          description: 'Track today\'s completed workouts.',
        ),
        const SizedBox(height: 16),
        _ResultCard(
          title: 'Today\'s Progress',
          value: '$completedCount / ${workouts.length}',
          subtitle: orientation == Orientation.portrait
              ? 'Portrait mode'
              : 'Landscape mode',
          icon: Icons.task_alt,
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                for (final entry in workouts.entries)
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(entry.key),
                    secondary: const Icon(Icons.fitness_center),
                    value: entry.value,
                    onChanged: (value) {
                      setState(() {
                        workouts[entry.key] = value ?? false;
                      });
                    },
                  ),
                const SizedBox(height: 10),
                LinearProgressIndicator(value: progress),
                const SizedBox(height: 8),
                Text('${(progress * 100).round()}% completed'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
       
        Card(
          child: SizedBox(
            height: 130,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.fitness_center,
                  size: 100,
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                ),
                const Text(
                  'KEEP GOING!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



class _ModuleHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ModuleHeader({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 42),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputCard extends StatelessWidget {
  final List<Widget> children;

  const _InputCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(children: children),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  const _ResultCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 44),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(subtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
