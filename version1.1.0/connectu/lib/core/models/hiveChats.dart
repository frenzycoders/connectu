import 'package:hive/hive.dart';
part 'hiveChats.g.dart';

@HiveType(typeId: 1)
class Chats {
  @HiveField(0)
  String messageId;

  @HiveField(1)
  String number;

  @HiveField(2)
  bool isSender;

  @HiveField(4)
  String chat_message;

  @HiveField(5)
  String file_path;

  @HiveField(6)
  String status;

  @HiveField(7)
  String send_time;

  @HiveField(8)
  String recieve_time;

  @HiveField(9)
  String seen_time;

  @HiveField(10)
  String date;

  Chats({
    required this.messageId,
    this.isSender = false,
    required this.number,
    this.chat_message = '',
    this.file_path = '',
    this.status = '',
    this.send_time = '',
    this.recieve_time = '',
    this.seen_time = '',
    this.date = '',
  });
}
