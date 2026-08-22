import 'package:flutter/material.dart';

class SafetyChecklistScreen extends StatefulWidget {
  final String category;

  const SafetyChecklistScreen({super.key, required this.category});

  @override
  State<SafetyChecklistScreen> createState() => _SafetyChecklistScreenState();
}

class _SafetyChecklistScreenState extends State<SafetyChecklistScreen> {
  late List<String> questions;
  late List<bool> answers;

  @override
  void initState() {
    super.initState();
    questions = _questionsForCategory(widget.category);
    answers = List<bool>.filled(questions.length, false);
  }

  List<String> _questionsForCategory(String category) {
    switch (category) {
      case 'Battery Safety':
        return [
          'Batteries are not producing fire or heat',
          'Battery terminals are protected',
          'No damaged batteries in use',
          'PPE is worn when handling batteries',
        ];

      case 'Electrical Wires Safety':
        return [
          'No naked wires around technician',
          'Cables have no cuts',
          'Wires are kept away from water',
          'Sockets and plugs are intact',
        ];

      case 'Grinder Safety':
        return [
          'Grinder disc is tightened',
          'Grinder guard is installed',
          'Grinder is used correctly',
          'Operator is wearing PPE',
        ];

      case 'Hooks & Cables Safety':
        return [
          'Hooks have no cuts',
          'Cables are not frayed',
          'Hooks are stable and secure',
          'Technician works safely around hooks',
        ];

      case 'PPE Wear':
        return [
          'Helmet is worn',
          'Gloves are worn',
          'Safety shoes are worn',
          'High‑visibility vest is worn',
        ];

      default:
        return ['No questions defined for this category'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.category} Checklist")),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(questions[index]),
            value: answers[index],
            onChanged: (value) {
              setState(() {
                answers[index] = value!;
              });
            },
          );
        },
      ),
    );
  }
}
