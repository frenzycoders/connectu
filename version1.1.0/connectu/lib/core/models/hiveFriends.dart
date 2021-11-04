import 'package:hive/hive.dart';

part 'hiveFriends.g.dart';

@HiveType(typeId: 2)
class Friend {
  @HiveField(0)
  String contactId;

  @HiveField(1)
  String id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String displayName;

  @HiveField(4)
  String status;

  @HiveField(5)
  String number;

  @HiveField(6)
  String img;

  Friend({
    this.contactId = '',
    required this.id,
    required this.name,
    this.displayName = '',
    this.status = '',
    required this.number,
    this.img = '',
  });
}
