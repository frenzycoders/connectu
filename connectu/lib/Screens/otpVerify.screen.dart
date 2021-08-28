import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_field/otp_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              'Verify Yourself',
              style: GoogleFonts.yrsa(
                color: Colors.blueGrey,
                letterSpacing: .5,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              'One Time password was sent on your +91 9262715527',
              style: TextStyle(color: Colors.blueGrey),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Wrong Number'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 40,
              style: TextStyle(fontSize: 15),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                print("Completed: " + pin);
                Get.toNamed('/home');
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: RaisedButton(
              color: Colors.pink.shade400,
              onPressed: () {},
              child: Text(
                'RESEND',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
