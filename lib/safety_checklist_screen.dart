import 'package:flutter/material.dart';

class SafetyChecklistScreen extends StatefulWidget {
  const SafetyChecklistScreen({super.key});

  @override
  State<SafetyChecklistScreen> createState() => _SafetyChecklistScreenState();
}

class _SafetyChecklistScreenState extends State<SafetyChecklistScreen> {
  final Map<String, bool> checklist = {
    "Battery Safety": false,
    "Electrical Wires Safety": false,
    "Grinder Safety": false,
    "Hooks & Cables Safety": false,
    "PPE Wear": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Safety Checklist")),
      body: ListView(
        children: checklist.keys.map((item) {
          return CheckboxListTile(
            title: Text(item),
            value: checklist[item],
            onChanged: (value) {
              setState(() {
                checklist[item] = value!;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
