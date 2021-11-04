import 'package:connectu/core/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    'Settings',
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          GetX<UserController>(
            builder: (controller) {
              return Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                height: 100,
                child: ListTile(
                  onTap: () {
                    Get.toNamed('/general-profile-screen');
                  },
                  leading: CircleAvatar(
                    radius: 25,
                    child: CircleAvatar(
                      radius: 23,
                      foregroundImage: controller.user.value.img == 'N'
                          ? NetworkImage(controller.serverAddress +
                              'public/user_default.png')
                          : NetworkImage(controller.serverAddress +
                              controller.user.value.img),
                    ),
                  ),
                  title: Text(
                    controller.user.value.name == 'N'
                        ? 'Guest'
                        : controller.user.value.name,
                    style: GoogleFonts.yrsa(
                      color: Colors.blueGrey,
                      letterSpacing: .5,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('Edit Your profile details.'),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListTile(
              onTap: () {
                //changeName(pro.user.name);
              },
              leading: Icon(Icons.privacy_tip),
              title: Text(
                'Privacy & Security',
                style: GoogleFonts.yrsa(
                  color: Colors.blueGrey,
                  letterSpacing: .5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Manage your privacy and security.'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListTile(
              onTap: () {
                //changeName(pro.user.name);
              },
              leading: Icon(Icons.cloud),
              title: Text(
                'Chats & Backup',
                style: GoogleFonts.yrsa(
                  color: Colors.blueGrey,
                  letterSpacing: .5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Manage your chats and backup.'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListTile(
              onTap: () {
                //changeName(pro.user.name);
              },
              leading: Icon(Icons.delete),
              title: Text(
                'Delete Account',
                style: GoogleFonts.yrsa(
                  color: Colors.blueGrey,
                  letterSpacing: .5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Delete Your account.'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListTile(
              onTap: () {
                //changeName(pro.user.name);
              },
              leading: Icon(Icons.new_label),
              title: Text(
                'Change Number',
                style: GoogleFonts.yrsa(
                  color: Colors.blueGrey,
                  letterSpacing: .5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Change your number.'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListTile(
              onTap: () {
                //changeName(pro.user.name);
              },
              leading: Icon(Icons.feedback),
              title: Text(
                'FeedBack',
                style: GoogleFonts.yrsa(
                  color: Colors.blueGrey,
                  letterSpacing: .5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Please drop your valuable feedback.'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListTile(
              onTap: () {
                //changeName(pro.user.name);
              },
              leading: Icon(Icons.details),
              title: Text(
                'About us',
                style: GoogleFonts.yrsa(
                  color: Colors.blueGrey,
                  letterSpacing: .5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Learn about us.'),
            ),
          ),
        ],
      ),
    );
  }
}
