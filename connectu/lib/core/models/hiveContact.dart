import 'package:hive/hive.dart';
part 'hiveContact.g.dart';

@HiveType(typeId: 4)
class HiveContcats {
  @HiveField(0)
  String contactId;

  @HiveField(1)
  String id;

  @HiveField(2)
  String displayName;

  @HiveField(3)
  String name;

  @HiveField(4)
  String number;

  @HiveField(5)
  bool connected;

  @HiveField(6)
  String status;

  @HiveField(7)
  String img;

  HiveContcats({
    required this.contactId,
    required this.id,
    this.displayName = '',
    this.name = '',
    required this.number,
    this.connected = false,
    this.status = '',
    this.img = '',
  });
}
