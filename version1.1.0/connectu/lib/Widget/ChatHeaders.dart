import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectu/core/controllers/chatsController.dart';
import 'package:connectu/core/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './../utils/Config.dart';

class ChatHeader extends StatefulWidget {
  User user;
  ChatHeader({required this.user});

  @override
  _ChatHeaderState createState() => _ChatHeaderState();
}

class _ChatHeaderState extends State<ChatHeader> {
  late ChatController _chatController;
  final String apiAddress = AppConfig.apiAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatController = Get.find<ChatController>();
    _chatController.id = widget.user.id;
    _chatController.userOnlieChekUp();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        //height: 90,
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: CircleAvatar(
                            radius: 23,
                            backgroundImage: widget.user.img == null
                                ? CachedNetworkImageProvider(
                                    apiAddress + 'public/user_default.png')
                                : CachedNetworkImageProvider(
                                    apiAddress + widget.user.img),
                          ),
                        ),
                        title: Text(
                          widget.user.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Obx(() {
                          return Text(
                            _chatController.online.toString(),
                            style:
                                TextStyle(color: Colors.white54, fontSize: 12),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  // height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.video_call,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.call,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
