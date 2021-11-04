import 'dart:io';
import 'package:connectu/core/controllers/user_controller.dart';
import 'package:connectu/service/http/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class GeneralProfileScreen extends StatelessWidget {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _statusEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetX<UserController>(builder: (controller) {
        _nameEditingController.text = controller.user.value.name;
        _statusEditingController.text = controller.user.value.bio;
        return Column(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.pink.shade400,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Container(
                    child: Text(
                      'Profile',
                      style: GoogleFonts.yrsa(
                        color: Colors.white,
                        letterSpacing: .5,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed('/settings');
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.pink.shade400,
                          radius: 80,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                controller.user.value.img == 'N'
                                    ? controller.serverAddress +
                                        'public/user_default.png'
                                    : controller.serverAddress +
                                        controller.user.value.img),
                            radius: 76,
                            child: Container(
                              color: Colors.transparent,
                              margin: EdgeInsets.only(right: 20),
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () async {
                                    try {
                                      await controller.pickImage();
                                      // ignore: unnecessary_null_comparison
                                      if (controller.image != null)
                                        controller.messageDialogue(
                                            Text('Change Image'),
                                            Container(
                                              height: 150,
                                              width: 100,
                                              child: controller.isLoading.isTrue
                                                  ? Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : Image.file(
                                                      File(controller
                                                          .image!.path),
                                                      fit: BoxFit.cover),
                                            ),
                                            [
                                              IconButton(
                                                onPressed: () {
                                                  controller.image = null;
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  try {
                                                    await controller
                                                        .updateUserDetails(
                                                            {}, true);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            controller.snackBar(
                                                                'Profile Updated.'));
                                                    controller.image = null;
                                                    Navigator.of(context).pop();
                                                  } on HttpException catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            controller.snackBar(
                                                                e.message));
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            controller.snackBar(
                                                                'Connection error.'));
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.upload,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                            24.00,
                                            Colors.white,
                                            context);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(controller
                                              .snackBar('Some Error Occur!'));
                                    }
                                  },
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          controller.messageDialogue(
                            Text('NAME'),
                            TextField(
                              controller: _nameEditingController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 5.0),
                                ),
                              ),
                            ),
                            [
                              RaisedButton(
                                elevation: 5,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('BACK'),
                              ),
                              controller.isLoading.isTrue
                                  ? FlatButton(
                                      onPressed: () {},
                                      child: CircularProgressIndicator(),
                                    )
                                  : RaisedButton(
                                      elevation: 5,
                                      color: Colors.pink.shade400,
                                      onPressed: () async {
                                        try {
                                          await controller.updateUserDetails({
                                            'name': _nameEditingController.text
                                          }, false);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(controller.snackBar(
                                                  'Name Changed Succss..'));
                                          Navigator.of(context).pop();
                                        } on HttpException catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(controller
                                                  .snackBar(e.message));
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(controller.snackBar(
                                                  'Connection error.'));
                                        }
                                      },
                                      child: Text(
                                        'SAVE',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                            ],
                            24.00,
                            Colors.white,
                            context,
                          );
                        },
                        leading: Icon(Icons.person),
                        title: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name',
                                      style: GoogleFonts.yrsa(
                                        color: Colors.blueGrey,
                                        letterSpacing: .5,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.edit,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                        subtitle: Text(controller.user.value.name == 'N'
                            ? 'Guest'
                            : controller.user.value.name),
                      ),
                      ListTile(
                        onTap: () {
                          controller.messageDialogue(
                            Text('STATUS'),
                            TextField(
                              controller: _statusEditingController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 5.0),
                                ),
                              ),
                            ),
                            [
                              RaisedButton(
                                elevation: 5,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('BACK'),
                              ),
                              RaisedButton(
                                elevation: 5,
                                color: Colors.pink.shade400,
                                onPressed: () async {
                                  try {
                                    await controller.updateUserDetails(
                                        {'bio': _statusEditingController.text},
                                        false);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        controller.snackBar(
                                            'Status Changed Succss..'));
                                    Navigator.of(context).pop();
                                  } on HttpException catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        controller.snackBar(e.message));
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        controller
                                            .snackBar('Connection error.'));
                                  }
                                },
                                child: Text(
                                  'SAVE',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                            24.00,
                            Colors.white,
                            context,
                          );
                        },
                        leading: Icon(Icons.info_outline),
                        title: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'About',
                                      style: GoogleFonts.yrsa(
                                        color: Colors.blueGrey,
                                        letterSpacing: .5,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.edit,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                        subtitle: Text(controller.user.value.bio == 'N'
                            ? 'Not Added.'
                            : controller.user.value.bio),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text(
                          'Your Number',
                          style: GoogleFonts.yrsa(
                            color: Colors.blueGrey,
                            letterSpacing: .5,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('+91 ' + controller.user.value.number),
                      ),
                      ListTile(
                        leading: Icon(Icons.feedback),
                        title: Text(
                          'Feedback',
                          style: GoogleFonts.yrsa(
                            color: Colors.blueGrey,
                            letterSpacing: .5,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('rate on play store.'),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
