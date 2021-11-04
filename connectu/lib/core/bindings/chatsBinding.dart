import 'package:connectu/core/controllers/chatsController.dart';
import 'package:get/get.dart';

class ChatsBinding extends Bindings {
  @override
  void dependencies() {
    print('Binding Chats Controller....');
    // TODO: implement dependencies
    Get.put(ChatController());
  }
}
