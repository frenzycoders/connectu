import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralProfileScreen extends StatelessWidget {
  const GeneralProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        radius: 80,
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: () {
                                //getImage();
                              },
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        //changeName(pro.user.name);
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
                      subtitle: Text('Gaurav Singh'),
                    ),
                    ListTile(
                      onTap: () {
                        //changAbout(pro.user.status);
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
                      subtitle: Text('SOme Status'),
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
                      subtitle: Text('+91 9262715527'),
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
      ),
    );
  }
}
