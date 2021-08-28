import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'JOIN',
                  style: GoogleFonts.yrsa(
                    color: Colors.pink.shade400,
                    letterSpacing: .5,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' US',
                  style: GoogleFonts.yrsa(
                    color: Colors.blueGrey,
                    letterSpacing: .5,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 55,
                child: Icon(Icons.person),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: FlatButton(
                    minWidth: 50,
                    color: Colors.pink.shade400,
                    padding: EdgeInsets.all(0),
                    child: Text(
                      '+91 ',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: TextField(),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: RaisedButton(
              elevation: 4,
              onPressed: () {
                Get.toNamed('/otp-verification');
              },
              color: Colors.pink.shade400,
              child: Container(
                height: 60,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'NEXT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
