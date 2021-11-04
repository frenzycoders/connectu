import 'package:connectu/core/controllers/user_controller.dart';
import 'package:connectu/service/socket/socket_service.dart';
import 'package:connectu/utils/Config.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketServiceImpl implements SocketService {
  var _baseUrl;
  late UserController _userController;
  late IO.Socket _socket;
  @override
  void init() {
    // TODO: implement init
    _baseUrl = AppConfig.apiAddress;
    _userController = Get.find<UserController>();
    _socket = IO.io(
        _baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({
              'token':
                  _userController.token == null ? 'N' : _userController.token
            })
            .build());

    _socket.connect();
  }

  @override
  onSocketConnected(Function callback) {
    _socket.onConnect((data) {
      callback(data);
    });
  }

  @override
  onSocketError(Function callback) {
    _socket.onConnectError((data) {
      callback(data);
    });
  }

  @override
  onSocketDisconnect(Function callback) {
    _socket.onDisconnect((data) {
      callback(data);
    });
  }

  @override
  onSocketConnectionTimeout(Function callback) {
    _socket.onConnectTimeout((data) {
      callback(data);
    });
  }

  @override
  onError(Function callback) {
    _socket.onError((data) {
      callback(data);
    });
  }

  @override
  onCloseConnection(Function onCloseConnection) {
    _socket.clearListeners();
    onCloseConnection();
  }

  @override
  emitServerSocketEvent(String event_name, data) {
    _socket.emit(event_name, data);
  }

  @override
  createSocketEvent(String event_name, Function callback) {
    _socket.on(event_name, (data) => callback(data));
  }

  @override
  disconnectSocket(Function cb) {
    _socket.disconnect();
    cb();
  }

}
