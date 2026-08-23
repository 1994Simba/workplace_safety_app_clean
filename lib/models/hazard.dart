import 'package:hive/hive.dart';

part 'hazard.g.dart';

@HiveType(typeId: 0)
class Hazard {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String imagePath;

  @HiveField(3)
  final DateTime timestamp;

  Hazard({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.timestamp,
  });

  static Future<List<Hazard>> loadHazards() async {
    final box = Hive.box('hazards');
    final List<Hazard> hazards = [];

    for (var key in box.keys) {
      final data = box.get(key);
      if (data is Hazard) hazards.add(data);
    }

    return hazards;
  }
}
