import 'package:hive/hive.dart';

part 'hazard.g.dart';

@HiveType(typeId: 1)
class Hazard extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String imagePath;

  @HiveField(3)
  DateTime timestamp;

  @HiveField(4)
  String severity; // NEW

  Hazard({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.timestamp,
    required this.severity,
  });
}
