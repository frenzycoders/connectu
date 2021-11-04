import 'package:connectu/Widget/BubbleChats.dart';
import 'package:connectu/core/controllers/chatsController.dart';
import 'package:connectu/utils/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatItem extends StatefulWidget {
  bool fromMe;
  final String text;
  final String status;
  final String img;
  final messageId;
  final recieverNumber;
  ChatItem({
    required this.fromMe,
    required this.text,
    required this.status,
    required this.img,
    required this.messageId,
    required this.recieverNumber,
  });

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  late ChatController _chatController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatController = Get.find<ChatController>();
    if (!widget.fromMe && widget.status != 'SEEN') {
      _chatController.emeitMessageSeen(widget.messageId, widget.recieverNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    Alignment alignment =
        widget.fromMe ? Alignment.topRight : Alignment.topLeft;
    Alignment chatArrowAlignment =
        widget.fromMe ? Alignment.topRight : Alignment.topLeft;
    TextStyle textStyle = TextStyle(
      fontSize: 16.0,
      color: Colors.black54,
    );
    Color chatBgColor = widget.fromMe ? Colors.green.shade200 : Colors.black12;
    EdgeInsets edgeInsets = widget.fromMe
        ? EdgeInsets.fromLTRB(5, 5, 15, 5)
        : EdgeInsets.fromLTRB(15, 5, 5, 5);
    EdgeInsets margins = widget.fromMe
        ? EdgeInsets.fromLTRB(80, 5, 10, 5)
        : EdgeInsets.fromLTRB(10, 5, 80, 5);
    return Container(
      margin: margins,
      child: Align(
        alignment: alignment,
        child: Column(
          children: <Widget>[
            CustomPaint(
              painter: ChatBubble(color: chatBgColor, alignment: alignment),
              child: Container(
                margin: EdgeInsets.all(0),
                child: Stack(
                  children: <Widget>[
                    ListTile(
                      title: Padding(
                        padding: edgeInsets,
                        child: Text(
                          widget.text,
                          style: textStyle,
                        ),
                      ),
                      subtitle: Padding(
                          padding: edgeInsets,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 6),
                                child: CircleAvatar(
                                  radius: 7,
                                  backgroundImage: NetworkImage(
                                      widget.img == 'N'
                                          ? AppConfig.apiAddress +
                                              'public/user_default.png'
                                          : AppConfig.apiAddress + widget.img),
                                ),
                              ),
                              widget.fromMe
                                  ? Container(
                                      margin: EdgeInsets.only(right: 6),
                                      child: widget.status == 'PENDING'
                                          ? Icon(
                                              Icons.timer,
                                              color: Colors.red,
                                              size: 15,
                                            )
                                          : widget.status == 'SEND'
                                              ? Icon(
                                                  Icons.check_circle,
                                                  color: Colors.blueGrey,
                                                  size: 15,
                                                )
                                              : widget.status == 'RECIEVE'
                                                  ? Icon(
                                                      Icons.check_circle,
                                                      color: Colors.yellow,
                                                      size: 15,
                                                    )
                                                  : Icon(
                                                      Icons.check_circle,
                                                      color: Colors.blue,
                                                      size: 15,
                                                    ),
                                    )
                                  : Container(),
                              Text(
                                'At 03:45 PM Today',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
