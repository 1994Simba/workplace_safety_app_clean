// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hazard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HazardAdapter extends TypeAdapter<Hazard> {
  @override
  final int typeId = 1;

  @override
  Hazard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hazard(
      title: fields[0] as String,
      description: fields[1] as String,
      imagePath: fields[2] as String,
      timestamp: fields[3] as DateTime,
      severity: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Hazard obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.severity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HazardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
