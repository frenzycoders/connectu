import 'package:connectu/core/controllers/contactController.dart';
import 'package:connectu/core/controllers/hiveController.dart';
import 'package:connectu/core/models/hiveChats.dart';
import 'package:connectu/core/models/hiveContact.dart';
import 'package:connectu/core/models/hiveFriends.dart';
import 'package:connectu/core/models/hiveLastMessage.dart';
import 'package:connectu/core/models/socketMessageModel.dart';
import 'package:connectu/core/controllers/RTCcontroller.dart';
import 'package:connectu/core/controllers/user_controller.dart';
import 'package:connectu/core/models/user.model.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  late UserController _userController;
  late RTCcontroller _rtCcontroller;
  late HiveController _hiveController;
  late ContactController _contactController;
  late User _user;
  String id = '';
  Rx<String> online = ''.obs;

  RxList friends = [].obs;
  RxList chats = [].obs;
  List _chatUpdateTypes = ['STATUS', 'MESSAGE'];
  ChatController() {
    print('Chat COntroller initilized');
    _userController = Get.find<UserController>();
    _rtCcontroller = Get.find<RTCcontroller>();
    _hiveController = Get.find<HiveController>();
    _contactController = Get.find<ContactController>();
    _user = _userController.user.value;
    fetchChats();
    fetchFriends();
    _rtCcontroller.userOnlineEventResponse(userOnlieResponse);
    _rtCcontroller.globalUserStatus(globalOnlineEvent);
    _rtCcontroller.userConnectedGlobal(userConnectedGlobal);
    _rtCcontroller.pendingMessageRecieve(recievePendingMessages);
    _rtCcontroller.messageReciever(receiveMessage);
    _rtCcontroller.recieveSendMessageAck(messageSendStatusReciever);
    _rtCcontroller.messageRecievedStatusEvent(messageRecievedStatusEvent);
    _rtCcontroller.messageSeenResponse(messageSeenResponse);
  }

  List _chatStatus = ['PENDING', 'SEND', 'RECIEVE', 'SEEN', 'FAILED'];

  fetchFriends() async {
    List<Friend> f = await _hiveController.fetchFriends() as List<Friend>;

    if (f.length == 0)
      friends.value = [];
    else
      friends.value = f;
  }

  fetchChats() async {
    List<Chats> c = await _hiveController.fetchAllChats() as List<Chats>;
    if (c.length == 0)
      chats.value = [];
    else
      chats.value = c;
  }

  recievePendingMessages(data) async {
    List list = data as List;
    data.forEach((element) {
      SockectMessageModel sockectMessageModel =
          SockectMessageModel.fromJSON(element);
      storePendingMessages(sockectMessageModel);
    });
  }

  storePendingMessages(SockectMessageModel messageModel) async {
    print(messageModel.reciever_meta.bio);
    final friend =
        await _hiveController.fetchFriendAsId(messageModel.sender_id);
    if (!friend) {
      try {
        HiveContcats contact =
            await _hiveController.getContactInfo(messageModel.sender_number);
        await _hiveController.addFriend(Friend(
          id: contact.id,
          name: contact.name,
          number: contact.number,
          contactId: contact.contactId,
          displayName: contact.displayName,
          img: contact.img,
          status: contact.status,
        ));
      } catch (e) {
        await _hiveController.addFriend(Friend(
          id: messageModel.sender_meta.id,
          name: messageModel.sender_meta.name,
          number: messageModel.sender_meta.number,
          contactId: '',
          displayName: '',
          img: messageModel.sender_meta.img,
          status: messageModel.sender_meta.bio,
        ));
      }
    }
    final recieveTime = DateTime.now().toString();
    await _hiveController.insertChatstoDb(Chats(
      messageId: messageModel.messageId,
      number: messageModel.sender_number,
      chat_message: messageModel.message,
      date: DateTime.now().toString(),
      file_path: messageModel.file,
      isSender: false,
      recieve_time: recieveTime,
      seen_time: '',
      send_time: messageModel.message_sendtime,
      status: _chatStatus[2],
    ));
    await _hiveController.storeLastMessage(LastMessage(
      number: messageModel.sender_number,
      message: messageModel.messageId,
    ));
    await fetchChats();
    _rtCcontroller.messageRecievedStatusEmitter(
        messageModel.messageId, messageModel.reciever_number);
  }

  sendMessageUserToUser(SockectMessageModel messageModel) async {
    final friend =
        await _hiveController.fetchFriendAsId(messageModel.reciever_id);
    if (!friend) {
      await _hiveController.addFriend(Friend(
        id: messageModel.reciever_meta.id,
        name: messageModel.reciever_meta.name,
        number: messageModel.reciever_meta.number,
        contactId: messageModel.reciever_meta.contactId,
        img: messageModel.reciever_meta.img,
        status: messageModel.reciever_meta.bio,
      ));
      fetchFriends();
    }
    messageModel.messageId =
        DateTime.now().toIso8601String() + '@' + _user.id + '@' + _user.number;
    final date = DateTime.now().toString();
    if (messageModel.reciever_id == _user.id ||
        messageModel.reciever_number == _user.number) {
      await _hiveController.insertChatstoDb(Chats(
        messageId: messageModel.messageId,
        isSender: true,
        number: messageModel.reciever_number,
        chat_message: messageModel.message,
        file_path: messageModel.file,
        date: date,
        recieve_time: date,
        seen_time: date,
        send_time: date,
        status: _chatStatus[3],
      ));
      await _hiveController.storeLastMessage(LastMessage(
        number: messageModel.reciever_number,
        message: messageModel.messageId,
      ));
      await fetchChats();
    } else {
      messageModel.sender_id = _user.id;
      messageModel.sender_number = _user.number;
      final sendTime = DateTime.now().toString();
      messageModel.message_sendtime = sendTime;

      await _hiveController.insertChatstoDb(Chats(
        messageId: messageModel.messageId,
        isSender: true,
        number: messageModel.reciever_number,
        chat_message: messageModel.message,
        file_path: messageModel.file,
        date: date,
        recieve_time: '',
        seen_time: '',
        send_time: sendTime,
        status: _chatStatus[0],
      ));
      await _hiveController.storeLastMessage(LastMessage(
        number: messageModel.reciever_number,
        message: messageModel.messageId,
      ));
      await fetchChats();
      emitsendMessage(messageModel);
    }
  }

  insertMessagetoDb(SockectMessageModel messageModel) async {}

  emitsendMessage(SockectMessageModel messageModel) async {
    _rtCcontroller.emitUserToUserMessageSend(messageModel);
    // await fetchChats();
  }

  messageSendStatusReciever(data) async {
    try {
      await _hiveController.updateChatItem(
          data['id'], _chatUpdateTypes[0], _chatStatus[1]);
      await fetchChats();
      await _hiveController.storeLastMessage(
          LastMessage(number: data['r_number'], message: data['id']));
    } catch (e) {
      print(e);
    }
  }

  receiveMessage(data) async {
    print(data);
    SockectMessageModel messageModel = SockectMessageModel.fromJSON(data);
    storePendingMessages(messageModel);
  }

  messageRecievedStatusEvent(data) async {
    try {
      await _hiveController.updateChatItem(
          data['id'], _chatUpdateTypes[0], _chatStatus[2]);
      await fetchChats();
      await _hiveController.storeLastMessage(
          LastMessage(number: data['r_number'], message: data['id']));
    } catch (e) {
      print(e);
    }
  }

  emeitMessageSeen(mid, r_number) async {
    _rtCcontroller.emitmessageSeenEvent(mid, r_number);
    fetchChats();
    await _hiveController.updateChatItem(
        mid, _chatUpdateTypes[0], _chatStatus[3]);
    await fetchChats();
    await _hiveController
        .storeLastMessage(LastMessage(number: mid.split('@')[2], message: mid));
  }

  messageSeenResponse(data) async {
    await _hiveController.updateChatItem(
        data['mid'], _chatUpdateTypes[0], _chatStatus[3]);
    await fetchChats();
    await _hiveController.storeLastMessage(
        LastMessage(number: data['r_number'], message: data['mid']));
  }

  userOnlieChekUp() {
    _rtCcontroller.emitUserOnlieEvent(id);
  }

  userOnlieResponse(data) {
    if (data['status'] == true)
      online.value = 'Online';
    else
      online.value = data['lastseen'];
  }

  globalOnlineEvent(data) {
    if (data['id'] == id) {
      online.value = data['lastseen'];
    }
  }

  userConnectedGlobal(data) {
    
    if (data == id) online.value = 'online';
  }
}
