import 'package:hive/hive.dart';

part 'hiveProfile.g.dart';

@HiveType(typeId: 0)
class Profile {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(3)
  String number;

  @HiveField(5)
  String img;

  @HiveField(6)
  String status;

  Profile({
    required this.id,
    required this.name,
    required this.number,
    this.img = '',
    this.status = '',
  });
}
