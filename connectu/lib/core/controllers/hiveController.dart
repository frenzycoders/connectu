import 'package:connectu/core/models/hiveChats.dart';
import 'package:connectu/core/models/hiveContact.dart';
import 'package:connectu/core/models/hiveFriends.dart';
import 'package:connectu/core/models/hiveLastMessage.dart';
import 'package:connectu/core/models/hiveProfile.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HiveController extends GetxController {
  late Box<Profile> profileBox;
  late Box<Chats> chatsBox;
  late Box<Friend> friendsBox;
  late Box<HiveContcats> hiveContactsBox;
  late Box<LastMessage> lastMessageBox;
  String profile = 'profile';
  String chats = 'chats';
  String friends = 'friends';
  String contacts = 'contacts';
  String lastMessage = 'lastMessage';
  HiveController() {
    initDb();
  }
  initDb() async {
    profileBox = await Hive.box<Profile>(profile);
    chatsBox = await Hive.box<Chats>(chats);
    friendsBox = await Hive.box<Friend>(friends);
    hiveContactsBox = await Hive.box<HiveContcats>(contacts);
    lastMessageBox = await Hive.box<LastMessage>(lastMessage);
  }

  Future addContact(List<HiveContcats> list) async {
    hiveContactsBox.addAll(list);
  }

  Future<List> fetchContacts() async {
    return hiveContactsBox.values.toList();
  }

  Future deleteAllContacts() async {
    await hiveContactsBox.deleteAll(hiveContactsBox.keys);
  }

  Future emptyUserProfile() async {
    await profileBox.deleteAll(profileBox.keys);
  }

  Future addProfile(Profile profile) async {
    await profileBox.put(profile.id, profile);
  }

  Future<Profile> getProfile(id) async {
    Profile profile = await profileBox.get(id) as Profile;
    return profile;
  }

  Future<Profile> updateProfile(String id, Profile profile) async {
    await profileBox.put(id, profile);
    return profile;
  }

  Future<List> fetchFriends() async {
    return friendsBox.values.toList();
  }

  Future fetchFriendAsId(id) async {
    var friend = await friendsBox.get(id);
    if (friend == null)
      return false;
    else
      return true;
  }

  Future addFriend(Friend friend) async {
    try {
      await friendsBox.put(friend.id, friend);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List> fetchAllChats() async {
    return chatsBox.values.toList();
  }

  Future insertChatstoDb(Chats chats) async {
    try {
      await chatsBox.put(chats.messageId, chats);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future updateChatItem(String key, String field, String value) async {
    try {
      Chats? chats = await chatsBox.get(key) as Chats;
      if (chats == null)
        print('No Found');
      else {
        chats.status = value;
        chats.send_time = DateTime.now().toString();
        chatsBox.put(key, chats);
        return chats;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<Chats?> getChatById(mid) async {
    Chats? chats = await chatsBox.get(mid) as Chats;
    if (chats == null) return null;
    return chats;
  }

  Future<HiveContcats> getContactInfo(number) async {
    try {
      var output = await hiveContactsBox.values
          .where((element) => element.number == '$number');
      return output.first;
    } catch (e) {
      throw e;
    }
  }

  fetchLastMessagebyId(key) {
    Chats chats = chatsBox.get(key) as Chats;
    print(chats.chat_message);
    return chats;
  }

  Future storeLastMessage(LastMessage lastMessage) async {
    await lastMessageBox.put(lastMessage.number, lastMessage);
  }
}
