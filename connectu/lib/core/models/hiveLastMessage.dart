import 'package:hive/hive.dart';
part 'hiveLastMessage.g.dart';

@HiveType(typeId: 6)
class LastMessage {
  @HiveField(0)
  String number;

  @HiveField(1)
  String message;

  LastMessage({required this.number, required this.message});
}
