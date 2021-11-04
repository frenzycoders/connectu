import 'package:connectu/core/controllers/user_controller.dart';
import 'package:connectu/service/http/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    print(controller.user.value.number);
    print(controller.user.value.img);
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
          GetX<UserController>(
            builder: (controller) {
              return Container(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: controller.user.value.img == 'N'
                        ? NetworkImage(controller.serverAddress +
                            'public/user_default.png')
                        : NetworkImage(controller.serverAddress +
                            controller.user.value.img),
                  ),
                ),
              );
            },
          ),
          GetX<UserController>(
            builder: (controller) {
              return Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  'One Time password was sent on your +91 ' +
                      controller.user.value.number,
                  style: TextStyle(color: Colors.blueGrey),
                ),
              );
            },
          ),
          !controller.inputLoading.isTrue
              ? Container(
                  child: TextButton(
                    onPressed: () {
                      Get.offAndToNamed('/join-user');
                    },
                    child: Text('Wrong Number'),
                  ),
                )
              : Container(),
          GetX<UserController>(builder: (controller) {
            return controller.inputLoading.isTrue
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(20),
                    child: OTPTextField(
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 40,
                      style: TextStyle(fontSize: 15),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      onCompleted: (pin) async {
                        try {
                          await controller.verifyOtp(pin);
                          ScaffoldMessenger.of(context).showSnackBar(
                              controller.snackBar('Verification Completed.'));
                          if (controller.contactPermission.isTrue)
                            Get.offAndToNamed('/home');
                          else
                            Get.offAndToNamed('/permission-screen');
                        } on HttpException catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(controller.snackBar(e.message));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(controller
                              .snackBar('check internet connection.'));
                        }
                      },
                    ),
                  );
          }),
          Container(
            padding: EdgeInsets.all(20),
            child: GetX<UserController>(
              builder: (controller) {
                return controller.inputLoading.isTrue
                    ? Container()
                    : controller.isLoading.isTrue
                        ? Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : RaisedButton(
                            color: Colors.pink.shade400,
                            onPressed: () async {
                              try {
                                await controller
                                    .resendOtp(controller.user.value.number);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    controller
                                        .snackBar('OTP Sended Successfully..'));
                              } on HttpException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    controller.snackBar(e.message));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    controller.snackBar(
                                        'Please Check Your Connection'));
                              }
                            },
                            child: Text(
                              'RESEND',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
              },
            ),
          )
        ],
      ),
    );
  }
}
