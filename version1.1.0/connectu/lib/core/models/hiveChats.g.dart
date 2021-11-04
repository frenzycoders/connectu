// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveChats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatsAdapter extends TypeAdapter<Chats> {
  @override
  final int typeId = 1;

  @override
  Chats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chats(
      messageId: fields[0] as String,
      isSender: fields[2] as bool,
      number: fields[1] as String,
      chat_message: fields[4] as String,
      file_path: fields[5] as String,
      status: fields[6] as String,
      send_time: fields[7] as String,
      recieve_time: fields[8] as String,
      seen_time: fields[9] as String,
      date: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Chats obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.messageId)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.isSender)
      ..writeByte(4)
      ..write(obj.chat_message)
      ..writeByte(5)
      ..write(obj.file_path)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.send_time)
      ..writeByte(8)
      ..write(obj.recieve_time)
      ..writeByte(9)
      ..write(obj.seen_time)
      ..writeByte(10)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
