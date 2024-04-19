// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CitiesEntityAdapter extends TypeAdapter<CitiesEntity> {
  @override
  final int typeId = 3;

  @override
  CitiesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CitiesEntity(
      error: fields[0] as bool,
      msg: fields[1] as String,
      data: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, CitiesEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.error)
      ..writeByte(1)
      ..write(obj.msg)
      ..writeByte(2)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CitiesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
