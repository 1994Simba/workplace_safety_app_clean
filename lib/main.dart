import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/hazard.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the Hazard adapter
  Hive.registerAdapter(HazardAdapter());

  // Open the hazards box
  await Hive.openBox<Hazard>('hazards');

  runApp(const WorkplaceSafetyApp());
}

class WorkplaceSafetyApp extends StatelessWidget {
  const WorkplaceSafetyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workplace Safety',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
