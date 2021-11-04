// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveFriends.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FriendAdapter extends TypeAdapter<Friend> {
  @override
  final int typeId = 2;

  @override
  Friend read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Friend(
      contactId: fields[0] as String,
      id: fields[1] as String,
      name: fields[2] as String,
      displayName: fields[3] as String,
      status: fields[4] as String,
      number: fields[5] as String,
      img: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Friend obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.contactId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.displayName)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.number)
      ..writeByte(6)
      ..write(obj.img);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FriendAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
