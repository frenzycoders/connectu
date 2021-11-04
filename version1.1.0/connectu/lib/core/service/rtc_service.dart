abstract class RTCservice {
  onSocketConnected(Function cb);
  onCloseConnection(Function cb);
  onSocketError(Function cb);
  onError(Function cb);
  onDisconnect(Function cb);
  onTimeOut(Function cb);
  emitSocketEvent(String event_name, data);
  createSocketEvent(String event_name, Function cb);
  disconnectSocket(Function cb);
}
