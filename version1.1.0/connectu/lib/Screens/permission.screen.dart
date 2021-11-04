import 'package:connectu/core/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    return Scaffold(body: Obx(() {
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                'Activate Permission',
                style: GoogleFonts.yrsa(
                  color: Colors.blueGrey,
                  letterSpacing: .5,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: controller.contactPermission.isTrue
                            ? [Colors.green, Colors.greenAccent]
                            : [Colors.white, Colors.white])),
                child: ListTile(
                  onTap: () {
                    if (controller.contactPermission.isTrue) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(controller.snackBar('Already granted'));
                    } else {
                      controller.requestContactPermission();
                    }
                  },
                  leading: Icon(Icons.contacts_sharp),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Contacts'),
                      controller.contactPermission.isTrue
                          ? Icon(Icons.done)
                          : Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
              ),
            ),
            controller.contactPermission.isTrue
                ? Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: RaisedButton(
                      color: Colors.pinkAccent,
                      onPressed: () {
                        Get.offAndToNamed('/home');
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text('NEXT'),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      );
    }));
  }
}
