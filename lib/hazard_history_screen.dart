import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/hazard.dart';
import 'dart:io';

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

                final hasImage = h.imagePath != null &&
                    h.imagePath!.isNotEmpty &&
                    File(h.imagePath!).existsSync();

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),

                    leading: SizedBox(
                      width: 60,
                      height: 60,
                      child: hasImage
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                File(h.imagePath!),
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(Icons.warning, size: 40, color: Colors.orange),
                    ),

                    title: Text(h.title),
                    subtitle: Text(h.description),

                    trailing: Text(
                      "${h.timestamp.day}/${h.timestamp.month}/${h.timestamp.year}",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
