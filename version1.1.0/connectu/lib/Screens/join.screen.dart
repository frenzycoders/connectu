import 'package:connectu/core/controllers/user_controller.dart';
import 'package:connectu/service/http/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class JoinScreen extends StatelessWidget {
  TextEditingController _numberController = TextEditingController();
  late String countryCode;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    //print(controller);
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
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
          Container(
            padding: const EdgeInsets.all(20),
            child: const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 55,
                child: Icon(Icons.person),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // ignore: deprecated_member_use
                FlatButton(
                  minWidth: 50,
                  color: Colors.pink.shade400,
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    '+91 ',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _numberController,
                      decoration:
                          const InputDecoration(prefixIcon: Icon(Icons.phone)),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Obx(() {
              return controller.isLoading.isTrue
                  ? const Center(
                    child: CircularProgressIndicator(),
                  )
                  // ignore: deprecated_member_use
                  : RaisedButton(
                      elevation: 4,
                      onPressed: () async {
                        try {
                          if (_numberController.text.isEmpty ||
                              _numberController.text.length < 10) {
                            controller.messageDialogue(
                                const Text('Error!'),
                                const Text('Please Enter valid number'),
                                [
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Okay'))
                                ],
                                24.00,
                                Colors.white,
                                context);
                          }
                          await controller.joinUser(
                              '+91', _numberController.text);
                          // ignore: deprecated_member_use
                          if (!controller.user.value.isNull) {
                            Get.offAndToNamed('/otp-verification');
                          }
                        } on HttpException catch (e) {
                          controller.messageDialogue(
                              Text('Server Error!'),
                              Text(e.message),
                              [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Okay'))
                              ],
                              24.00,
                              Colors.white,
                              context);
                        } catch (e) {
                          print(e);
                          controller.messageDialogue(
                              Text('Connection Error!'),
                              Text('Check your internet connection.'),
                              [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Okay'))
                              ],
                              24.00,
                              Colors.white,
                              context);
                        }
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
                    );
            }),
          )
        ],
      ),
    );
  }
}
