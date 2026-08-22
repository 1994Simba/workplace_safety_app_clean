import 'package:flutter/material.dart';
import 'hazard_report_screen.dart';
import 'safety_checklist_screen.dart';
import 'hazard_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workplace Safety'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SafetyChecklistScreen(category: 'General'),
                  ),
                );
              },
              child: const Text('Safety Checklist'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportHazardScreen(),
                  ),
                );
              },
              child: const Text('Report Hazard'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HazardHistoryScreen(),
                  ),
                );
              },
              child: const Text('Hazard History'),
            ),
          ],
        ),
      ),
    );
  }
}
