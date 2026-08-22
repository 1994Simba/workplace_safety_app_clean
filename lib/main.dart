import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/hazard.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(HazardAdapter());
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

      // ⭐ ALWAYS start with LoginScreen
      home: const LoginScreen(),
    );
  }
}
