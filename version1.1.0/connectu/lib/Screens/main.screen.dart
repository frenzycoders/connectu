import 'package:connectu/Widget/HomeListTile.dart';
import 'package:connectu/core/controllers/chatsController.dart';
import 'package:connectu/core/controllers/contactController.dart';

import 'package:connectu/core/controllers/RTCcontroller.dart';
import 'package:connectu/core/controllers/user_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final rtcController = Get.find<RTCcontroller>();
    final chatController = Get.find<ChatController>();
    final contactController = Get.find<ContactController>();
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      body: Obx(() {
        return Column(
          children: [
            Container(
              height: 150,
              width: double.infinity, //MediaQuery.of(context).size.height / 7,
              decoration: BoxDecoration(
                color: Colors.pink.shade400,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'ConnectU',
                                  style: GoogleFonts.yrsa(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: rtcController.isConnected.isTrue
                                          ? Colors.green
                                          : Colors.red),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.toNamed('/settings');
                            },
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed('/general-profile-screen');
                                    },
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          userController.user.value.img == 'N'
                                              ? userController.serverAddress +
                                                  'public/user_default.png'
                                              : userController.serverAddress +
                                                  userController.user.value.img,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      userController.user.value.name == 'N'
                                          ? 'Guest'
                                          : userController.user.value.name,
                                      style: GoogleFonts.yrsa(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.toNamed('/archive-chats');
                                  },
                                  icon: Icon(
                                    Icons.archive,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Get.toNamed('/search-screen');
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Get.toNamed('/add-friend');
                                  },
                                  icon: Icon(
                                    Icons.person_add,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              return Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: chatController.friends.value.length > 0
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return HomeListTile(
                              user: chatController.friends.value[index],
                            );
                          },
                          itemCount: chatController.friends.value.length,
                        )
                      : Center(
                          child: Text('No Chats Found'),
                        ),
                ),
              );
            })
          ],
        );
      }),
    );
  }
}
