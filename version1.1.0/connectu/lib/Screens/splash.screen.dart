import 'dart:async';
import 'package:connectu/core/controllers/user_controller.dart';
import 'package:connectu/service/http/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  splashCounter() {
    // return Timer(Duration(seconds: 2), moveToAuthenticationCheckup);
    moveToAuthenticationCheckup();
  }

  void moveToAuthenticationCheckup() async {
    final controller = Get.find<UserController>();
    final prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    final token = await prefs.getString('userToken');
    await controller.contactPermissionCheckup();
    controller.token = token;
    try {
      await controller.tokenAuh(token);
      ScaffoldMessenger.of(context)
          .showSnackBar(controller.snackBar('Wow! Logged In...'));
      if (controller.contactPermission.isTrue)
        Get.toNamed('/home');
      else
        Get.toNamed('/permission-screen');
    } on HttpException catch (e) {
      controller.token = null;
      ScaffoldMessenger.of(context)
          .showSnackBar(controller.snackBar(e.message));
      Get.toNamed('/join-user');
    } catch (e) {
      if (token == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(controller.snackBar('Login First.'));
        Get.toNamed('/join-user');
      } else {
        try {
          controller.fetchOfflineUser();
          Get.toNamed('/home');
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(controller.snackBar('Login First.'));
          Get.toNamed('/join-user');
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
    splashCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
