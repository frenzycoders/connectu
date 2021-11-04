import 'package:connectu/core/models/user.model.dart';

class SockectMessageModel {
  String messageId;
  String message;
  String message_sendtime;
  String file;
  String sender_number;
  String sender_id;
  String reciever_number;
  String reciever_id;
  User reciever_meta;
  User sender_meta;
  SockectMessageModel(
      {this.messageId = '',
      required this.message,
      this.message_sendtime = '',
      this.file = '',
      this.sender_id = '',
      this.sender_number = '',
      required this.reciever_id,
      required this.reciever_number,
      required this.reciever_meta,
      required this.sender_meta});

  SockectMessageModel.fromJSON(Map<String, dynamic> json)
      : messageId = json['messageId'],
        message = json['message'],
        message_sendtime = json['message_sendtime'],
        file = json['file'] == null || json['file'] == '' ? '' : json['file'],
        sender_number = json['sender_number'] == null
            ? json['messageId'].toString().split('@')[2]
            : json['sender_number'],
        sender_id = json['sender_id'],
        reciever_number = json['reciever_number'],
        reciever_id = json['reciever_id'],
        reciever_meta = User.fromJson(json['reciever_meta']),
        sender_meta = User.fromJson(json['sender_meta']);
}
