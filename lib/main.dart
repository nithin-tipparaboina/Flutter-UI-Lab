import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const FitTrackApp());
}

// ============================================================
// APP
// ============================================================

class FitTrackApp extends StatelessWidget {
  const FitTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF16845B),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F8F7),
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      home: const FitTrackHome(),
    );
  }
}

// ============================================================
// MAIN NAVIGATION
// ============================================================

class FitTrackHome extends StatefulWidget {
  const FitTrackHome({super.key});

  @override
  State<FitTrackHome> createState() => _FitTrackHomeState();
}

class _FitTrackHomeState extends State<FitTrackHome> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    DashboardPage(),
    BmiPage(),
    CaloriesPage(),
    WorkoutPage(),
  ];

  final List<String> titles = const [
    'FitTrack',
    'BMI Calculator',
    'Calorie Calculator',
    'Workout Tracker',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Profile',
            onPressed: () => openFeature(
              context,
              const RegistrationPage(),
              'Profile',
            ),
            icon: const Icon(Icons.account_circle_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.monitor_weight_outlined),
            label: 'BMI',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_fire_department_outlined),
            label: 'Calories',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DASHBOARD
// ============================================================

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final features = <_Feature>[
      _Feature(
        'Responsive Layout',
        'Adapts to different screen sizes',
        Icons.devices,
        const ResponsivePage(),
      ),
      _Feature(
        'Activity Counter',
        'Track your activity with a counter',
        Icons.add_circle_outline,
        const CounterPage(),
      ),
      _Feature(
        'Profile Setup',
        'Enter your fitness profile details',
        Icons.person_outline,
        const RegistrationPage(),
      ),
      _Feature(
        'Animations',
        'Explore interactive animations',
        Icons.animation,
        const AnimationPage(),
      ),
      _Feature(
        'UI Components',
        'Explore reusable interface elements',
        Icons.widgets_outlined,
        const ComponentsPage(),
      ),
      _Feature(
        'Navigation Demo',
        'Explore app navigation',
        Icons.navigation_outlined,
        const NavigationDemoPage(),
      ),
      _Feature(
        'Fitness Data',
        'Load sample user data from an API',
        Icons.cloud_download_outlined,
        const ApiPage(),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 3
            : constraints.maxWidth >= 550
                ? 2
                : 1;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF116B4A),
                      Color(0xFF28A878),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                      size: 36,
                    ),
                    SizedBox(height: 18),
                    Text(
                      'Your fitness journey starts here.',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Track workouts, understand your body, '
                      'and stay consistent.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Your Fitness Tools',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: features.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 125,
                ),
                itemBuilder: (context, index) {
                  final feature = features[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => openFeature(
                      context,
                      feature.page,
                      feature.title,
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                              child: Icon(feature.icon),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feature.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    feature.description,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Feature {
  final String title;
  final String description;
  final IconData icon;
  final Widget page;

  const _Feature(
    this.title,
    this.description,
    this.icon,
    this.page,
  );
}

void openFeature(
  BuildContext context,
  Widget page,
  String title,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => FeatureScaffold(
        title: title,
        child: page,
      ),
    ),
  );
}

class FeatureScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const FeatureScaffold({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(child: child),
    );
  }
}

// ============================================================
// BMI CALCULATOR
// ============================================================

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  double? bmi;
  String category = '';

  void calculateBMI() {
    final height = double.tryParse(heightController.text);
    final weight = double.tryParse(weightController.text);

    if (height == null ||
        weight == null ||
        height <= 0 ||
        weight <= 0 ||
        height > 300 ||
        weight > 500) {
      showMessage(context, 'Enter valid height and weight.');
      return;
    }

    final heightInMeters = height / 100;
    final result = weight / (heightInMeters * heightInMeters);

    setState(() {
      bmi = result;

      if (result < 18.5) {
        category = 'Underweight';
      } else if (result < 25) {
        category = 'Normal weight';
      } else if (result < 30) {
        category = 'Overweight';
      } else {
        category = 'Obesity range';
      }
    });
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Body Mass Index',
            subtitle: 'Estimate your BMI using your height and weight.',
          ),
          const SizedBox(height: 20),
          AppTextField(
            controller: heightController,
            label: 'Height in centimetres',
            icon: Icons.height,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: weightController,
            label: 'Weight in kilograms',
            icon: Icons.monitor_weight_outlined,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: calculateBMI,
              icon: const Icon(Icons.calculate),
              label: const Text('Calculate BMI'),
            ),
          ),
          if (bmi != null) ...[
            const SizedBox(height: 24),
            ResultCard(
              title: 'Your BMI',
              value: bmi!.toStringAsFixed(1),
              subtitle: category,
              icon: Icons.monitor_weight,
            ),
            const SizedBox(height: 12),
            const Text(
              'Adult BMI categories are general screening ranges, '
              'not a diagnosis. BMI may not accurately represent '
              'body composition for every person.',
            ),
          ],
        ],
      ),
    );
  }
}

// ============================================================
// CALORIE CALCULATOR
// ============================================================

class CaloriesPage extends StatefulWidget {
  const CaloriesPage({super.key});

  @override
  State<CaloriesPage> createState() => _CaloriesPageState();
}

class _CaloriesPageState extends State<CaloriesPage> {
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  String sex = 'Male';
  String activity = 'Moderately active';
  double? calories;

  final activityMultipliers = const {
    'Sedentary': 1.2,
    'Lightly active': 1.375,
    'Moderately active': 1.55,
    'Very active': 1.725,
  };

  void calculateCalories() {
    final age = int.tryParse(ageController.text);
    final weight = double.tryParse(weightController.text);
    final height = double.tryParse(heightController.text);

    if (age == null ||
        weight == null ||
        height == null ||
        age < 1 ||
        age > 120 ||
        weight <= 0 ||
        weight > 500 ||
        height <= 0 ||
        height > 300) {
      showMessage(context, 'Enter valid age, weight, and height.');
      return;
    }

    // Mifflin-St Jeor equation: estimated resting energy expenditure.
    final bmr = sex == 'Male'
        ? 10 * weight + 6.25 * height - 5 * age + 5
        : 10 * weight + 6.25 * height - 5 * age - 161;

    setState(() {
      calories = bmr * activityMultipliers[activity]!;
    });
  }

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Daily Calorie Estimate',
            subtitle: 'Estimate calories needed to maintain your weight.',
          ),
          const SizedBox(height: 20),
          AppTextField(
            controller: ageController,
            label: 'Age in years',
            icon: Icons.cake_outlined,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: weightController,
            label: 'Weight in kilograms',
            icon: Icons.monitor_weight_outlined,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: heightController,
            label: 'Height in centimetres',
            icon: Icons.height,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 18),
          const Text(
            'Sex used in the equation',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: sex,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Male', child: Text('Male')),
              DropdownMenuItem(value: 'Female', child: Text('Female')),
            ],
            onChanged: (value) {
              if (value != null) setState(() => sex = value);
            },
          ),
          const SizedBox(height: 18),
          const Text(
            'Activity level',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: activity,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: activityMultipliers.keys
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => activity = value);
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: calculateCalories,
              icon: const Icon(Icons.local_fire_department),
              label: const Text('Estimate Calories'),
            ),
          ),
          if (calories != null) ...[
            const SizedBox(height: 24),
            ResultCard(
              title: 'Estimated daily calories',
              value: calories!.round().toString(),
              subtitle: 'kcal/day to maintain weight',
              icon: Icons.local_fire_department,
            ),
            const SizedBox(height: 12),
            const Text(
              'This is an estimate, not a medical or dietary prescription. '
              'Actual needs vary with health, growth, training, and goals.',
            ),
          ],
        ],
      ),
    );
  }
}

// ============================================================
// WORKOUT TRACKER
// ============================================================

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final exercises = <String, bool>{
    'Push-ups': false,
    'Squats': false,
    'Pull-ups': false,
    'Dumbbell curls': false,
    'Shoulder press': false,
    'Plank': false,
  };

  @override
  Widget build(BuildContext context) {
    final completed =
        exercises.values.where((value) => value).length;

    final progress = completed / exercises.length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SectionTitle(
          title: 'Today\'s Workout',
          subtitle: 'Check off each exercise as you complete it.',
        ),
        const SizedBox(height: 20),
        ResultCard(
          title: 'Workout progress',
          value: '$completed / ${exercises.length}',
          subtitle: '${(progress * 100).round()}% completed',
          icon: Icons.fitness_center,
        ),
        const SizedBox(height: 18),
        LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          borderRadius: BorderRadius.circular(8),
        ),
        const SizedBox(height: 18),
        ...exercises.keys.map(
          (exercise) => Card(
            child: CheckboxListTile(
              value: exercises[exercise],
              title: Text(
                exercise,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              secondary: const Icon(Icons.sports_gymnastics),
              onChanged: (value) {
                setState(() => exercises[exercise] = value ?? false);
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            setState(() {
              for (final exercise in exercises.keys) {
                exercises[exercise] = false;
              }
            });
          },
          icon: const Icon(Icons.refresh),
          label: const Text('Reset Workout'),
        ),
      ],
    );
  }
}

// ============================================================
// RESPONSIVE LAYOUT
// ============================================================

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 650;

        final cards = [
          const _InfoCard(
            icon: Icons.monitor_weight,
            title: 'Body Metrics',
            description: 'Review your height and weight.',
          ),
          const _InfoCard(
            icon: Icons.local_fire_department,
            title: 'Nutrition',
            description: 'Estimate your daily energy needs.',
          ),
          const _InfoCard(
            icon: Icons.fitness_center,
            title: 'Training',
            description: 'Keep track of your exercises.',
          ),
        ];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(
                title: isWide ? 'Fitness Overview' : 'Your Overview',
                subtitle: isWide
                    ? 'Wide-screen responsive layout'
                    : 'Compact layout for smaller screens',
              ),
              const SizedBox(height: 20),
              if (isWide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cards
                      .map(
                        (card) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: card,
                          ),
                        ),
                      )
                      .toList(),
                )
              else
                Column(
                  children: cards
                      .map(
                        (card) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: card,
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(description),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// COUNTER / STATE MANAGEMENT
// ============================================================

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.track_changes, size: 54),
            const SizedBox(height: 16),
            const Text(
              'Activity Counter',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 54,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Activity points'),
            const SizedBox(height: 22),
            Wrap(
              spacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: () => setState(() => count++),
                  icon: const Icon(Icons.add),
                  label: const Text('Increase'),
                ),
                OutlinedButton.icon(
                  onPressed: count > 0
                      ? () => setState(() => count--)
                      : null,
                  icon: const Icon(Icons.remove),
                  label: const Text('Decrease'),
                ),
                TextButton(
                  onPressed: () => setState(() => count = 0),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// REGISTRATION / PROFILE FORM
// ============================================================

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();

  String goal = 'Muscle gain';

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'Fitness Profile',
              subtitle: 'Set up your personal fitness details.',
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full name',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email address',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(value.trim())) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                prefixIcon: Icon(Icons.cake_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                final age = int.tryParse(value ?? '');
                if (age == null || age < 1 || age > 120) {
                  return 'Enter a valid age';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            const Text(
              'Fitness goal',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: goal,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Muscle gain',
                  child: Text('Muscle gain'),
                ),
                DropdownMenuItem(
                  value: 'Weight loss',
                  child: Text('Weight loss'),
                ),
                DropdownMenuItem(
                  value: 'General fitness',
                  child: Text('General fitness'),
                ),
                DropdownMenuItem(
                  value: 'Endurance',
                  child: Text('Endurance'),
                ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => goal = value);
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    showDialog<void>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Profile Details'),
                        content: Text(
                          'Name: ${nameController.text}\n'
                          'Email: ${emailController.text}\n'
                          'Age: ${ageController.text}\n'
                          'Goal: $goal\n\n'
                          'This demo does not save details to a server.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(dialogContext),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Validate Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ANIMATIONS
// ============================================================

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool expanded = false;
  double rotation = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeInOut,
              width: expanded ? 230 : 150,
              height: expanded ? 230 : 150,
              decoration: BoxDecoration(
                color: expanded
                    ? Colors.orange
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(
                  expanded ? 30 : 100,
                ),
              ),
              child: const Icon(
                Icons.fitness_center,
                color: Colors.white,
                size: 60,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Interactive Animations',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                setState(() => expanded = !expanded);
              },
              child: Text(
                expanded ? 'Shrink Shape' : 'Expand Shape',
              ),
            ),
            const SizedBox(height: 18),
            AnimatedRotation(
              turns: rotation,
              duration: const Duration(milliseconds: 500),
              child: Icon(
                Icons.autorenew,
                size: 65,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            OutlinedButton(
              onPressed: () {
                setState(() => rotation += 0.25);
              },
              child: const Text('Rotate Icon'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// REUSABLE UI COMPONENTS
// ============================================================

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SectionTitle(
          title: 'UI Components',
          subtitle: 'Reusable cards, buttons, and layout elements.',
        ),
        const SizedBox(height: 20),
        const ResultCard(
          title: 'Weekly Activity',
          value: '5 days',
          subtitle: 'Example summary card',
          icon: Icons.calendar_month,
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Training Progress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const LinearProgressIndicator(value: 0.7),
                const SizedBox(height: 8),
                Text(
                  '70% complete',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      avatar: const Icon(Icons.bolt, size: 18),
                      label: const Text('Active'),
                    ),
                    Chip(
                      avatar: const Icon(Icons.favorite, size: 18),
                      label: const Text('Healthy habits'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () => showMessage(
            context,
            'Your reusable button is working!',
          ),
          icon: const Icon(Icons.touch_app),
          label: const Text('Try Button'),
        ),
      ],
    );
  }
}

// ============================================================
// NAVIGATION DEMO
// ============================================================

class NavigationDemoPage extends StatelessWidget {
  const NavigationDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SectionTitle(
          title: 'Navigation',
          subtitle: 'Move between related app screens.',
        ),
        const SizedBox(height: 20),
        Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person_outline),
            ),
            title: const Text('Profile'),
            subtitle: const Text('View profile form'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => openFeature(
              context,
              const RegistrationPage(),
              'Profile',
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.animation),
            ),
            title: const Text('Animations'),
            subtitle: const Text('Open interactive animations'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => openFeature(
              context,
              const AnimationPage(),
              'Animations',
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.widgets_outlined),
            ),
            title: const Text('UI Components'),
            subtitle: const Text('Explore reusable widgets'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => openFeature(
              context,
              const ComponentsPage(),
              'UI Components',
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// REST API
// ============================================================

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  bool loading = false;
  String? error;
  List<dynamic> users = [];

  Future<void> loadUsers() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (response.statusCode != 200) {
        throw Exception('Server returned ${response.statusCode}');
      }

      final data = jsonDecode(response.body);

      if (data is! List) {
        throw const FormatException('Unexpected response format');
      }

      if (!mounted) return;

      setState(() {
        users = data;
        loading = false;
      });
    } catch (exception) {
      if (!mounted) return;

      setState(() {
        loading = false;
        error = 'Could not load data. Check your internet connection.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Fitness Community Data',
                subtitle: 'Example user data loaded from a public API.',
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: loading ? null : loadUsers,
                  icon: const Icon(Icons.cloud_download_outlined),
                  label: Text(
                    loading ? 'Loading...' : 'Load User Data',
                  ),
                ),
              ),
            ],
          ),
        ),
        if (loading)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        else if (error != null)
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  error!,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        else if (users.isEmpty)
          const Expanded(
            child: Center(
              child: Text('Tap the button to load sample users.'),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index] as Map<String, dynamic>;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${user['id']}'),
                    ),
                    title: Text('${user['name']}'),
                    subtitle: Text('${user['email']}'),
                    trailing: const Icon(Icons.person_outline),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

// ============================================================
// SHARED WIDGETS
// ============================================================

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  const ResultCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor:
                  Theme.of(context).colorScheme.primaryContainer,
              child: Icon(icon, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
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

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}