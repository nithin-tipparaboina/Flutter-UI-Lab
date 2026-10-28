import 'package:flutter/material.dart';

void main() {
  runApp(const FitTrackFormApp());
}

class FitTrackFormApp extends StatelessWidget {
  const FitTrackFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTrack Registration',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();

  String? _fitnessGoal;
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _submitted = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration completed successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      setState(() {
        _submitted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitTrack Registration'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.fitness_center,
                    size: 65,
                    color: Colors.teal,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Create Your Fitness Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Name field
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Enter your name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      if (value.trim().length < 2) {
                        return 'Name must contain at least 2 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  // Email field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'example@email.com',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }

                      final emailPattern =
                          RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                      if (!emailPattern.hasMatch(value.trim())) {
                        return 'Please enter a valid email address';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  // Age field
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      hintText: 'Enter your age',
                      prefixIcon: Icon(Icons.calendar_month),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your age';
                      }

                      final age = int.tryParse(value.trim());

                      if (age == null) {
                        return 'Age must be a number';
                      }

                      if (age < 13 || age > 100) {
                        return 'Age must be between 13 and 100';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  // Fitness goal dropdown
                  DropdownButtonFormField<String>(
                    initialValue: _fitnessGoal,
                    decoration: const InputDecoration(
                      labelText: 'Fitness Goal',
                      prefixIcon: Icon(Icons.flag),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Muscle Gain',
                        child: Text('Muscle Gain'),
                      ),
                      DropdownMenuItem(
                        value: 'Weight Loss',
                        child: Text('Weight Loss'),
                      ),
                      DropdownMenuItem(
                        value: 'Stay Fit',
                        child: Text('Stay Fit'),
                      ),
                      DropdownMenuItem(
                        value: 'Improve Endurance',
                        child: Text('Improve Endurance'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _fitnessGoal = value;
                        _submitted = false;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a fitness goal';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Submit Registration'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),

                  if (_submitted) ...[
                    const SizedBox(height: 24),
                    Card(
                      color: Colors.green.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Registration Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('Name: ${_nameController.text.trim()}'),
                            Text('Email: ${_emailController.text.trim()}'),
                            Text('Age: ${_ageController.text.trim()}'),
                            Text('Fitness Goal: $_fitnessGoal'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}