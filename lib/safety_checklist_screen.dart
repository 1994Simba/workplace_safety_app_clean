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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: checklist.keys.map((item) {
            final checked = checklist[item]!;
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    checked ? Icons.check_circle : Icons.circle_outlined,
                    color: checked ? Colors.greenAccent : Colors.white70,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Switch(
                    value: checked,
                    activeThumbColor: Colors.greenAccent,
                    activeTrackColor: Colors.greenAccent.withValues(alpha: 0.4),
                    onChanged: (value) {
                      setState(() => checklist[item] = value);
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
