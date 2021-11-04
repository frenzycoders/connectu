import 'dart:async';

import 'package:connectu/Widget/ChatFooter.dart';
import 'package:connectu/Widget/ChatHeaders.dart';
import 'package:connectu/Widget/ChatItem.dart';
import 'package:connectu/core/controllers/chatsController.dart';
import 'package:connectu/core/controllers/user_controller.dart';
import 'package:connectu/core/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController = ScrollController();

  void Scroll() {
    Timer(
      Duration(microseconds: 1),
      () =>
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(microseconds: 1),
      () =>
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
    );
    final args = ModalRoute.of(context)!.settings.arguments as User;
    ChatController chatController = Get.find<ChatController>();
    UserController userController = Get.find<UserController>();
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            ChatHeader(
              user: args,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Obx(() {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: chatController.chats.value.length,
                    itemBuilder: (context, index) {
                      if (chatController.chats.value[index].number ==
                          args.number) {
                        return ChatItem(
                          fromMe: chatController.chats.value[index].isSender,
                          text: chatController.chats.value[index].chat_message,
                          status: chatController.chats.value[index].status,
                          img: chatController.chats.value[index].isSender
                              ? userController.user.value.img
                              : args.img,
                          messageId:
                              chatController.chats.value[index].messageId,
                          recieverNumber: userController.user.value.number,
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }),
              ),
            ),
            ChatFooter(
              user: args,
              onSend: Scroll,
            ),
          ],
        ),
      ),
    );
  }
}
