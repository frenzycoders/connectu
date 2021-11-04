class User {
  String id;
  String name;
  String number;
  String bio;
  String img;
  String contactId;

  User({
    this.id = '',
    this.name = '',
    this.number = '',
    this.bio = '',
    this.img = '',
    this.contactId = '',
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? 'N' : json['name'],
        id = json['_id'],
        number = json['number'],
        bio = json['bio'] == null ? 'N' : json['bio'],
        img = json['img'] == null ? 'N' : json['img'],
        contactId = '';

  get value => null;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'number': number,
        'img': img,
        'bio': bio,
        'contactid': contactId
      };
}
