import 'dart:ui';

import 'package:connectu/core/controllers/contactController.dart';
import 'package:connectu/core/controllers/hiveController.dart';
import 'package:connectu/core/controllers/user_controller.dart';
import 'package:connectu/core/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({Key? key}) : super(key: key);

  @override
  _AddFriendScreenState createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  bool isSearch = false;
  void handleSearchHeader() {
    if (isSearch)
      isSearch = false;
    else
      isSearch = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final contactController = Get.find<ContactController>();
    UserController userController = Get.find<UserController>();
    HiveController _hiveController = Get.find<HiveController>();
    return Obx(() {
      return Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.pink.shade400,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  isSearch
                      ? Expanded(
                          child: Container(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search Contact',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Text(
                            'Contacts',
                            style: GoogleFonts.yrsa(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  !isSearch
                      ? Container(
                          padding: EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              handleSearchHeader();
                            },
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              handleSearchHeader();
                            },
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.white,
                            ),
                          ),
                        )
                ],
              ),
            ),
            Card(
              child: Container(
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text(
                    'New contact',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                child: ListTile(
                  leading: Icon(Icons.group_add),
                  title: Text(
                    'Create Groups',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ListView.builder(
                  // ignore: invalid_use_of_protected_member

                  itemCount: contactController.contacts.value.length,
                  itemBuilder: (context, index) {
                    print(contactController.contacts.value[index].connected);
                    //return Text('Hey');
                    return ListTile(
                      onTap: () {
                        if (contactController.contacts.value[index].connected !=
                            true) {
                          print('Invite');
                        } else {
                          Get.toNamed(
                            '/chats-screen',
                            arguments: User(
                                id: contactController.contacts.value[index].id,
                                number: contactController
                                    .contacts.value[index].number,
                                bio: contactController
                                    .contacts.value[index].status,
                                name: contactController
                                    .contacts.value[index].name,
                                img:
                                    contactController.contacts.value[index].img,
                                contactId: contactController
                                    .contacts.value[index].contactId),
                          );
                        }
                      },
                      leading: CircleAvatar(
                        radius: 25,
                        child: CircleAvatar(
                          radius: 22,
                          foregroundImage: NetworkImage(contactController.contacts.value[index].img == 'N' ?
                              userController.serverAddress +
                                  'public/user_default.png' : userController.serverAddress +
                                  contactController.contacts.value[index].img),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: new Container(
                              padding: new EdgeInsets.only(right: 13.0),
                              child: new Text(
                                contactController.contacts.value[index].displayName,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Roboto',
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          contactController.contacts.value[index].connected != true
                              ? FlatButton(
                                  color: Colors.pink,
                                  onPressed: () {},
                                  child: Text(
                                    'Invite',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      subtitle:
                          contactController.contacts.value[index].connected != true
                              ? Container()
                              : Text(
                                  contactController
                                      .contacts.value[index].status,
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Roboto',
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
        floatingActionButton: contactController.isLoadig.isTrue
            ? FloatingActionButton(
                onPressed: () {},
                child: CircularProgressIndicator(),
              )
            : FloatingActionButton(
                onPressed: () {
                  contactController.refreshContacts();
                },
                child: Icon(Icons.refresh),
              ),
      );
    });
  }
}
