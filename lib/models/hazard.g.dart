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
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      timestamp: fields[4] as DateTime,
      imagePath: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Hazard obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imagePath)
      ..writeByte(4)
      ..write(obj.timestamp);
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
