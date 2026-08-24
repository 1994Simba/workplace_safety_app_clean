import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HazardHistoryScreen extends StatefulWidget {
  const HazardHistoryScreen({super.key});

  @override
  State<HazardHistoryScreen> createState() => HazardHistoryScreenState();
}

class HazardHistoryScreenState extends State<HazardHistoryScreen> {
  List<Map<String, dynamic>> items = [];

  void refresh() {
    loadHazards();
  }

  void loadHazards() {
    final box = Hive.box('hazards');
    final keys = box.keys.toList();
    final hazards = box.values.toList();

    final combined = List.generate(hazards.length, (i) {
      return {
        "key": keys[i],
        "hazard": hazards[i],
      };
    });

    combined.sort((a, b) {
      final h1 = a["hazard"];
      final h2 = b["hazard"];

      final t1 = h1 is Map ? h1["timestamp"] : h1.timestamp;
      final t2 = h2 is Map ? h2["timestamp"] : h2.timestamp;

      return t2.compareTo(t1);
    });

    setState(() {
      items = combined;
    });
  }

  @override
  void initState() {
    super.initState();
    loadHazards();
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const SizedBox(height: 30),
            Expanded(
              child: items.isEmpty
                  ? const Center(
                      child: Text(
                        "No hazards reported yet",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final h = items[index]["hazard"];
                        final key = items[index]["key"];

                        final title = h is Map ? h["title"] : h.title;
                        final description = h is Map ? h["description"] : h.description;
                        final severity = h is Map ? h["severity"] : h.severity;
                        final timestamp = h is Map ? h["timestamp"] : h.timestamp;
                        final imagePath = h is Map ? h["imagePath"] : h.imagePath;

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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                                  onPressed: () async {
                                    final shouldDelete = await showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: const Color(0xFF203A43),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          title: const Text(
                                            "Delete Hazard",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: const Text(
                                            "Are you sure you want to delete this hazard report?",
                                            style: TextStyle(color: Colors.white70),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
                                              onPressed: () => Navigator.pop(context, false),
                                            ),
                                            TextButton(
                                              child: const Text("Delete", style: TextStyle(color: Colors.redAccent)),
                                              onPressed: () => Navigator.pop(context, true),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    if (shouldDelete == true) {
                                      final box = Hive.box('hazards');
                                      box.delete(key);
                                      loadHazards();
                                    }
                                  },
                                ),
                              ),
                              Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                description,
                                style: const TextStyle(color: Colors.white70, fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Severity: $severity",
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Reported: $timestamp",
                                style: const TextStyle(color: Colors.white54, fontSize: 14),
                              ),
                              if (imagePath != null &&
                                  imagePath.isNotEmpty &&
                                  File(imagePath).existsSync())
                                Container(
                                  margin: const EdgeInsets.only(top: 12),
                                  height: 180,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: FileImage(File(imagePath)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
