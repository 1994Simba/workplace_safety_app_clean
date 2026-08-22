class Hazard {
  final String id;
  final String description;
  final DateTime dateTime;
  final String? imagePath;

  Hazard({
    required this.id,
    required this.description,
    required this.dateTime,
    this.imagePath,
  });
}
