import 'models/hazard.dart';

class HazardStore {
  static final List<Hazard> _hazards = [];

  static void add(Hazard hazard) {
    _hazards.add(hazard);
  }

  static List<Hazard> get all => List.unmodifiable(_hazards);
}
