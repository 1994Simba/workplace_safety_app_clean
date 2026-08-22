import 'package:flutter/material.dart';
import 'hazard_report_screen.dart';
import 'safety_checklist_screen.dart';
import 'hazard_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Battery Safety',
      'Electrical Wires Safety',
      'Grinder Safety',
      'Hooks & Cables Safety',
      'PPE Wear',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workplace Safety'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(categories[index]),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SafetyChecklistScreen(
                              category: categories[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
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
