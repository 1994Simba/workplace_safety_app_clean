import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/hazard.dart';

class HazardHistoryScreen extends StatefulWidget {
  const HazardHistoryScreen({super.key});

  @override
  HazardHistoryScreenState createState() => HazardHistoryScreenState();
}

class HazardHistoryScreenState extends State<HazardHistoryScreen> {
  List<Hazard> hazards = [];

  void loadHazards() {
    final box = Hive.box('hazards');
    final List<Hazard> loaded = [];

    for (var key in box.keys) {
      final item = box.get(key);
      if (item is Hazard) loaded.add(item);
    }

    setState(() {
      hazards = loaded;
    });
  }

  void deleteHazard(int index) {
    final box = Hive.box('hazards');
    final key = box.keyAt(index);
    box.delete(key);
    loadHazards();
  }

  @override
  void initState() {
    super.initState();
    loadHazards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hazards.isEmpty
          ? const Center(child: Text("No hazards recorded yet"))
          : ListView.builder(
              itemCount: hazards.length,
              itemBuilder: (context, index) {
                final hazard = hazards[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(hazard.title),
                        subtitle: Text(hazard.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              hazard.timestamp.toLocal().toString().split('.')[0],
                              style: const TextStyle(fontSize: 12),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("Delete Hazard"),
                                    content: const Text("Are you sure you want to delete this hazard?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteHazard(index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Delete", style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      if (hazard.imagePath.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Image.file(
                            File(hazard.imagePath),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
