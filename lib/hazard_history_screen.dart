import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/hazard.dart';

class HazardHistoryScreen extends StatelessWidget {
  const HazardHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hazardBox = Hive.box<Hazard>('hazards');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hazard History"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              hazardBox.clear();
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<Hazard>>(
        valueListenable: hazardBox.listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                "No hazards reported yet.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // Newest first
          final hazards = box.values.toList().reversed.toList();

          return ListView.builder(
            itemCount: hazards.length,
            itemBuilder: (context, index) {
              final hazard = hazards[index];
              if (hazard == null) return const SizedBox.shrink();

              final String title = hazard.title ?? "";
              final String description = hazard.description ?? "";
              final String imagePath = hazard.imagePath ?? "";
              final DateTime? timestamp = hazard.timestamp;

              final bool hasImage =
                  imagePath.isNotEmpty && File(imagePath).existsSync();

              final String displayTitle =
                  title.isNotEmpty ? title : "Unnamed Hazard";

              final String displayDescription =
                  description.isNotEmpty ? description : "No description";

              final String displayTimestamp = timestamp != null
                  ? timestamp.toLocal().toString()
                  : "Unknown time";

              return Dismissible(
                key: ValueKey(hazard.key), // IMPORTANT FIX
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  hazardBox.delete(hazard.key); // PERMANENT FIX
                },
                child: Card(
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
                                File(imagePath),
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.warning,
                              size: 40,
                              color: Colors.orange,
                            ),
                    ),
                    title: Text(displayTitle),
                    subtitle: Text(
                      "$displayDescription\nReported: $displayTimestamp",
                    ),
                    isThreeLine: true,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
