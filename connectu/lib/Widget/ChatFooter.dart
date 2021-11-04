import 'package:connectu/core/controllers/chatsController.dart';
import 'package:connectu/core/controllers/user_controller.dart';
import 'package:connectu/core/models/socketMessageModel.dart';
import 'package:connectu/core/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatFooter extends StatelessWidget {
  User user;
  Function onSend;
  ChatFooter({required this.user, required this.onSend});
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatController = Get.find<ChatController>();
    final userController = Get.find<UserController>();
    return Container(
      padding: EdgeInsets.all(10),
      //height: 80,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.emoji_emotions,
                    color: Colors.orangeAccent,
                  )),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              height: 50,
              child: TextField(
                enableInteractiveSelection: true,
                controller: _textEditingController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.pinkAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Type something...'),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: IconButton(
                  color: Colors.green,
                  onPressed: () async {
                    if (_textEditingController.text != null) {
                      SockectMessageModel sockectMessageModel =
                          SockectMessageModel(
                        message: _textEditingController.text,
                        file: '',
                        reciever_id: user.id,
                        reciever_number: user.number,
                        reciever_meta: user,
                        sender_meta: userController.user.value,
                      );
                      chatController.sendMessageUserToUser(sockectMessageModel);
                      _textEditingController.text = '';
                      onSend();
                    }
                  },
                  icon: Icon(Icons.send_rounded)),
            ),
          )
        ],
      ),
    );
  }
}
