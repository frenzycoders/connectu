class User {
  String id;
  String name;
  String number;
  String bio;
  String img;

  User({
    this.id = '',
    this.name = '',
    this.number = '',
    this.bio = '',
    this.img = '',
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['_id'],
        number = json['number'],
        bio = json['bio'],
        img = json['img'];

  Map<String, dynamic> toJson() =>
      {'_id': id, 'name': name, 'number': number, 'img': img, 'bio': bio};
}
