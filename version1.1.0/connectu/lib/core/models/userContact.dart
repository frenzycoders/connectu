class UserContact {
  String contactId;
  String id;
  String name;
  String serverName;
  String number;
  bool isConnected;
  String status;
  String img;

  UserContact({
    required this.contactId,
    required this.id,
    required this.name,
    required this.serverName,
    required this.number,
    required this.isConnected,
    required this.status,
    required this.img,
  });

  UserContact.fromJson(Map<String, dynamic> json)
      : id = json['id'] == null ? 'N' : json['id'],
        contactId = json['contactId'],
        name = json['displayName'] == null ? 'N' : json['displayName'],
        serverName = json['serverName'] == null ? 'N' : json['serverName'],
        number = json['number'],
        isConnected = json['connected'],
        status = json['status'] == null ? 'N' : json['status'],
        img = json['img'] == null ? 'N' : json['img'];

  get value => null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'contactId': contactId,
        'name': name,
        'serverName': serverName,
        'number': number,
        'isConnected': isConnected,
        'status': status,
        'img': img,
      };
}
