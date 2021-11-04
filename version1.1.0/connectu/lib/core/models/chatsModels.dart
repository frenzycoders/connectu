import 'package:connectu/core/models/user.model.dart';

class ChatModel {
  final String mid;
  final String send_to;
  User send_from;
  final String chat_message;
  final String file_path;
  final String status;
  final String send_time;
  final String recieve_time;
  final String seen_time;
  final String date;
  ChatModel({
    required this.mid,
    required this.send_to,
    required this.send_from,
    this.chat_message = '',
    this.file_path = '',
    this.status = 'SEND',
    this.send_time = '',
    this.recieve_time = '',
    this.seen_time = '',
    this.date = '',
  });
}
