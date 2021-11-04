import 'package:connectu/core/models/chatsModels.dart';
import 'package:connectu/core/models/socketMessageModel.dart';
import 'package:connectu/core/service/rtc_service.dart';
import 'package:connectu/core/service/rtc_service_impl.dart';
import 'package:get/get.dart';

class RTCcontroller extends GetxController {
  late RTCservice _rtCservice;
  var socketMessage = 'Connecting'.obs;
  var isConnected = false.obs;
  var socketId = null;
  RTCcontroller() {
    _rtCservice = Get.find<RTCserviceImpl>();
    _rtCservice.onSocketConnected(onSocketConnected);
    _rtCservice.onDisconnect(onDisconnect);
    //_rtCservice.onCloseConnection(onCloseConnection);
    _rtCservice.onSocketError(onSocketError);
    _rtCservice.onTimeOut(onTimeOut);
    _rtCservice.onError(onError);
    _rtCservice.createSocketEvent('DISCONNECT_FROM_SERVER', disconnectSocket);
    _rtCservice.createSocketEvent(
        'GENERATED_TOKEN_ID_FROM_SERVER', generatedsocketId);
  }

  generatedsocketId(id) async {
    print(id);
    socketId = id;
  }

  onSocketConnected(data) {
    print('Connected to socket Server');
    isConnected.value = true;
    socketMessage = 'Connected'.obs;
  }

  onSocketError(data) {
    print(data);
    print('Socket Error');
  }

  onError(data) {
    print(data);
    print('Some error found');
    isConnected = false.obs;
    print(isConnected.value);
    socketMessage = 'Some error found'.obs;
  }

  onDisconnect(data) {
    print(data);
    print('Disconnected from socket server');
    isConnected.value = false;
    socketId = null;
    socketMessage = 'Socket Disconnected.'.obs;
  }

  onTimeOut(data) {
    print(data);
    print('Socket Connection Time out');
    isConnected = false.obs;
    socketMessage = 'Socket connection timeout'.obs;
  }

  showLoading() {
    isConnected.toggle();
  }

  hideLoading() {
    isConnected.toggle();
  }

  filtredContact(data) {
    _rtCservice.emitSocketEvent('REQUEST_FILTRED_CONTACTS', {data});
  }

  catchFiltredContact(Function cb) {
    _rtCservice.createSocketEvent('FILTRED_CONTACTS', cb);
  }

  disconnectSocket() {
    _rtCservice.disconnectSocket(changeSocketValue);
  }

  changeSocketValue() {
    isConnected.value = false;
    print('DIsconnected from server');
  }

  emitTypingEvent(data) {
    _rtCservice.emitSocketEvent('USER_TYPING', {data});
  }

  emitUserToUserMessageSend(SockectMessageModel sockectMessageModel) {
    var data = {
      "messageId": sockectMessageModel.messageId,
      "message": sockectMessageModel.message,
      "message_sendtime": sockectMessageModel.message_sendtime,
      "file": sockectMessageModel.file,
      "sender_number": sockectMessageModel.sender_number,
      "sender_id": sockectMessageModel.sender_id,
      "reciever_id": sockectMessageModel.reciever_id,
      "reciever_number": sockectMessageModel.reciever_number,
      "reciever_meta": sockectMessageModel.reciever_meta,
      "sender_meta": sockectMessageModel.sender_meta,
    };
    _rtCservice.emitSocketEvent('MESSAGE_SEND_REQUEST', data);
  }

  recieveSendMessageAck(Function cb) async {
    _rtCservice.createSocketEvent('MESSAGE_SEND', cb);
  }

  messageReciever(Function cb) {
    _rtCservice.createSocketEvent('RECIEVE_MESSAGE', cb);
  }

  pendingMessageRecieve(Function cb) {
    _rtCservice.createSocketEvent('PENDING_MESSAGES', cb);
  }

  messageRecievedStatusEmitter(String id, String number) {
    _rtCservice.emitSocketEvent(
        'MESSAGE_RECIEVED_ACKNOLEDGEMENT', {"id": id, "r_number": number});
  }

  messageRecievedStatusEvent(Function cb) {
    _rtCservice.createSocketEvent('MESSAGE_RECIEVED_EVENT', cb);
  }

  emitmessageSeenEvent(messageId, recieverNumber) {
    _rtCservice.emitSocketEvent('MESSAGE_SEEN_EVENT_FOR USER',
        {"mid": messageId, "r_number": recieverNumber});
  }

  messageSeenResponse(Function cb) {
    _rtCservice.createSocketEvent('MESSAGE_SEEN_RESPONSE', cb);
  }

  emitUserOnlieEvent(String id) {
    _rtCservice.emitSocketEvent('CHECK_USER_ONLINE', id);
  }

  userOnlineEventResponse(Function cb) {
    _rtCservice.createSocketEvent('USER_ONLINE_STATUS', cb);
  }

  globalUserStatus(Function cb) {
    _rtCservice.createSocketEvent('USER_OFFLINE_GLOBAL', cb);
  }

  userConnectedGlobal(Function cb) {
    _rtCservice.createSocketEvent('USER_CONNECTED', cb);
  }
}
