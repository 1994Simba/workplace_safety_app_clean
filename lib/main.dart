import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
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
