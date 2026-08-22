import 'package:flutter/material.dart';

class SafetyChecklistScreen extends StatelessWidget {
  final String category;

  const SafetyChecklistScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: const Center(child: Text('Checklist coming soon')),
    );
  }
}
