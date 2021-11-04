abstract class SocketService {
  void init();

  onSocketConnected(Function callback);
  onSocketError(Function callback);
  onSocketDisconnect(Function callback);
  onSocketConnectionTimeout(Function callback);
  onError(Function callback);
  onCloseConnection(Function callback);
  emitServerSocketEvent(String event_name, data);
  createSocketEvent(String event_name, Function callback);
  disconnectSocket(Function cb);
}
