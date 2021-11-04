import 'package:connectu/core/controllers/RTCcontroller.dart';
import 'package:connectu/core/controllers/contactController.dart';
import 'package:connectu/core/controllers/hiveController.dart';
import 'package:connectu/core/models/hiveChats.dart';
import 'package:connectu/core/models/hiveFriends.dart';
import 'package:connectu/core/models/hiveLastMessage.dart';
import 'package:connectu/core/models/user.model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectu/utils/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeListTile extends StatefulWidget {
  Friend user;
  HomeListTile({required this.user});

  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<HomeListTile> {
  late RTCcontroller _rtCcontroller;
  late ContactController _contactController;
  late HiveController _hiveController;
  late Chats lastMessage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rtCcontroller = Get.find<RTCcontroller>();
    _contactController = Get.find<ContactController>();
    _hiveController = Get.find<HiveController>();
    if (widget.user.contactId != 'NON') {
      getContactInfo(widget.user.contactId);
    } else
      widget.user.displayName = widget.user.number;
  }

  getContactInfo(id) async {
    final contact = await _contactController.fetchContactById(id);
    widget.user.displayName = contact.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      focusColor: Colors.pinkAccent,
      hoverColor: Colors.pink,
      onTap: () {
        Get.toNamed(
          '/chats-screen',
          arguments: User(
            id: widget.user.id,
            number: widget.user.number,
            bio: widget.user.status,
            name: widget.user.displayName,
            img: widget.user.img == 'N'
                ? 'public/user_default.png'
                : widget.user.img,
            contactId: widget.user.contactId,
          ),
        );
      },
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 25,
        child: CircleAvatar(
          radius: 23,
          foregroundImage: NetworkImage(
            widget.user.img == null || widget.user.img == 'N'
                ? AppConfig.apiAddress + 'public/user_default.png'
                : AppConfig.apiAddress + widget.user.img,
          ),
        ),
      ),
      title: Text(widget.user.displayName),
      subtitle: ValueListenableBuilder(
        valueListenable:
            Hive.box<LastMessage>(_hiveController.lastMessage).listenable(),
        builder: (context, Box<LastMessage> box, _) {
          LastMessage lastMessage = box.get(widget.user.number) as LastMessage;
          Chats chats =
              _hiveController.fetchLastMessagebyId(lastMessage.message);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: chats.isSender
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      chats.isSender
                          ? chats.status == 'SEND'
                              ? Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.grey,
                                  size: 15,
                                )
                              : chats.status == 'RECIEVE'
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.yellow,
                                      size: 15,
                                    )
                                  : chats.status == 'SEEN'
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.blue,
                                          size: 15,
                                        )
                                      : chats.status == 'PENDING'
                                          ? Icon(
                                              Icons.timer,
                                              color: Colors.pink,
                                              size: 15,
                                            )
                                          : Icon(
                                              Icons.sms_failed,
                                              color: Colors.red,
                                              size: 15,
                                            )
                          : Container(),
                      Text(
                        '24:59 AM',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: chats.isSender ? 6 : 9,
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  height: 20,
                  child: Text(
                    chats.chat_message,
                    style: TextStyle(
                      color: chats.isSender ? Colors.grey : chats.status != 'SEEN' ? Colors.black : Colors.grey,
                      fontWeight: chats.isSender ? FontWeight.w500 : chats.status != 'SEEN' ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              )

              // Text(
              //   chats.chat_message,
              //   overflow: TextOverflow.ellipsis,
              //   style: new TextStyle(
              //     fontSize: 15.0,
              //     fontFamily: 'Roboto',
              //     color: Colors.grey,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // Container(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Text('08:00 PM'),
              //       Icon(
              //         Icons.check,
              //         size: 15,
              //         color: Colors.green,
              //       )
              //     ],
              //   ),
              // )
            ],
          );
        },
      ),
    );
  }
}
