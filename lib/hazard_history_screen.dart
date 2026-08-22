import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/hazard.dart';

class HazardHistoryScreen extends StatelessWidget {
  const HazardHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hazardBox = Hive.box<Hazard>('hazards');
    final hazards = hazardBox.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Hazard History")),
      body: hazards.isEmpty
          ? const Center(child: Text("No hazards reported yet"))
          : ListView.builder(
              itemCount: hazards.length,
              itemBuilder: (context, index) {
                final h = hazards[index];
                return Card(
                  child: ListTile(
                    title: Text(h.title),
                    subtitle: Text(h.description),
                    trailing: Text(
                      "${h.timestamp.day}/${h.timestamp.month}/${h.timestamp.year}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}

