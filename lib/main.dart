import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'login_screen.dart';
import 'models/hazard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HazardAdapter());

  await Hive.openBox('accounts');
  await Hive.openBox('settings');
  await Hive.openBox('hazards');

  runApp(const SafetyApp());
}

class SafetyApp extends StatelessWidget {
  const SafetyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safety App',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const LoginScreen(),
      routes: {
        '/login': (_) => const LoginScreen(),
      },
    );
  }
}
