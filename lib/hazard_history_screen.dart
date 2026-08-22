import 'package:flutter/material.dart';
import 'hazard_store.dart';

class HazardHistoryScreen extends StatelessWidget {
  const HazardHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hazards = HazardStore.all;

    return Scaffold(
      appBar: AppBar(title: const Text('Hazard History')),
      body: hazards.isEmpty
          ? const Center(child: Text('No hazards reported yet'))
          : ListView.builder(
              itemCount: hazards.length,
              itemBuilder: (context, index) {
                final h = hazards[index];
                return ListTile(
                  title: Text(h.description),
                  subtitle: Text(h.dateTime.toString()),
                );
              },
            ),
    );
  }
}
