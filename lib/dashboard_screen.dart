import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Color severityColor(String level) {
    switch (level) {
      case "High":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('hazards');
    final hazards = box.values.whereType<dynamic>().toList();

    final highCount = hazards.where((h) => h.severity == "High").length;
    final mediumCount = hazards.where((h) => h.severity == "Medium").length;
    final lowCount = hazards.where((h) => h.severity == "Low").length;

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

            const SizedBox(height: 40),

            _severityCard("High", highCount, Colors.red),
            const SizedBox(height: 16),
            _severityCard("Medium", mediumCount, Colors.orange),
            const SizedBox(height: 16),
            _severityCard("Low", lowCount, Colors.green),

            const SizedBox(height: 40),

            Center(
              child: Text(
                "Total Hazards: ${highCount + mediumCount + lowCount}",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _severityCard(String label, int count, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "$count",
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
