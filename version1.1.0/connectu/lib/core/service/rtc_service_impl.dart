import 'package:connectu/core/service/rtc_service.dart';
import 'package:connectu/service/socket/socket_service.dart';
import 'package:connectu/service/socket/socket_service_Impl.dart';
import 'package:get/get.dart';

class RTCserviceImpl implements RTCservice {
  late SocketService _socketService;

  RTCserviceImpl() {
    _socketService = Get.put(SocketServiceImpl());
    _socketService.init();
  }

  @override
  onSocketConnected(Function cb) {
    _socketService.onSocketConnected(cb);
  }

  @override
  onCloseConnection(Function cb) {
    _socketService.onCloseConnection(cb);
  }

  @override
  onSocketError(Function cb) {
    _socketService.onSocketError(cb);
  }

  @override
  onError(Function cb) {
    _socketService.onError(cb);
  }

  @override
  onDisconnect(Function cb) {
    _socketService.onSocketDisconnect(cb);
  }

  @override
  onTimeOut(Function cb) {
    _socketService.onSocketConnectionTimeout(cb);
  }

  @override
  emitSocketEvent(String event_name, data) {
    _socketService.emitServerSocketEvent(event_name, data);
  }

  @override
  createSocketEvent(String event_name, Function cb) {
    _socketService.createSocketEvent(event_name, cb);
  }

  @override
  disconnectSocket(Function cb) {
    _socketService.disconnectSocket(cb);
  }

}
