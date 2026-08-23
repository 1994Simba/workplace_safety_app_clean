import 'package:flutter/material.dart';
import 'hazard_report_screen.dart';
import 'hazard_history_screen.dart';
import 'safety_checklist_screen.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final historyKey = GlobalKey<HazardHistoryScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Workplace Safety"),
        backgroundColor: Colors.blueGrey[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              final box = Hive.box('accounts');
              box.put('rememberMe', false);

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/login');
              });
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          const Center(child: Text("Dashboard")),
          HazardReportScreen(
            onHazardSaved: () {
              setState(() => currentIndex = 2);
              historyKey.currentState?.loadHazards();
            },
          ),
          HazardHistoryScreen(key: historyKey),
          const SafetyChecklistScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
          if (index == 2) {
            historyKey.currentState?.loadHazards();
          }
        },
        selectedItemColor: Colors.blueGrey[900],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: "Report"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.checklist), label: "Checklist"),
        ],
      ),
    );
  }
}
