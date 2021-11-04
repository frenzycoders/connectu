// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveContact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveContcatsAdapter extends TypeAdapter<HiveContcats> {
  @override
  final int typeId = 4;

  @override
  HiveContcats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveContcats(
      contactId: fields[0] as String,
      id: fields[1] as String,
      displayName: fields[2] as String,
      name: fields[3] as String,
      number: fields[4] as String,
      connected: fields[5] as bool,
      status: fields[6] as String,
      img: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveContcats obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.contactId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.number)
      ..writeByte(5)
      ..write(obj.connected)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.img);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveContcatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
