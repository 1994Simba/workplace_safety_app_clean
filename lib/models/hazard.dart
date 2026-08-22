import 'package:hive/hive.dart';

part 'hazard.g.dart';

@HiveType(typeId: 1)
class Hazard extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String? imagePath;

  @HiveField(4)
  DateTime timestamp;

  Hazard({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    this.imagePath,
  });
}
