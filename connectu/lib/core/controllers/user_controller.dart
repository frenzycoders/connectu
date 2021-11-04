import 'dart:io';
import 'package:connectu/core/controllers/hiveController.dart';
import 'package:connectu/core/models/hiveProfile.dart';
import 'package:connectu/core/service/user_service.dart';
import 'package:connectu/core/service/user_service_impl.dart';
import 'package:connectu/service/http/http_exception.dart';
import 'package:connectu/utils/Config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  late UserService _userService;
  late HiveController _hiveController;
  final serverAddress = AppConfig.apiAddress;
  late ImagePicker _imagePicker;

  UserController() {
    _userService = Get.find<UserServiceImpl>();
    _hiveController = Get.find<HiveController>();
    _imagePicker = ImagePicker();
  }

  var user = User().obs;
  RxBool isLoading = false.obs;
  RxBool inputLoading = false.obs;
  RxBool contactPermission = false.obs;
  String? token;
  File? image;

  Future pickImage() async {
    try {
      final pickedImage =
          await _imagePicker.getImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      throw e;
    }
  }

  profileString(key, id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, id);
  }

  joinUser(countryCode, number) async {
    try {
      showLoading();
      var result = await _userService.joinUser(number, countryCode);
      await _hiveController.emptyUserProfile();
      user = result.obs;
      await _hiveController.addProfile(Profile(
        id: user.value.id,
        name: user.value.name,
        number: user.value.number,
        img: user.value.img,
        status: user.value.bio,
      ));
      await profileString('user_profile', user.value.id);
      hideLoading();
    } on HttpException catch (e) {
      hideLoading();
      throw HttpException(e.message);
    } catch (e) {
      print(e);
      hideLoading();
      throw e;
    }
  }

  resendOtp(String number) async {
    try {
      showLoading();
      print(user.value.number);
      await _userService.resendOtp(user.value.number);
      hideLoading();
    } on HttpException catch (e) {
      hideLoading();
      throw HttpException(e.message);
    } catch (e) {
      hideLoading();
      throw e;
    }
  }

  verifyOtp(otp) async {
    try {
      inputLoading.toggle();
      final userToken = await _userService.getVerifiedAndToken(
          user.value.number, user.value.id, otp);
      token = userToken;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userToken', token.toString());
      inputLoading.toggle();
    } on HttpException catch (e) {
      inputLoading.toggle();
      throw HttpException(e.message);
    } catch (e) {
      inputLoading.toggle();
      throw e;
    }
  }

  tokenAuh(token) async {
    try {
      var res = await _userService.tokenBasedAuthentication(token);
      user = res.obs;
      await _hiveController.updateProfile(
          user.value.id,
          Profile(
            id: user.value.id,
            name: user.value.name,
            number: user.value.number,
            img: user.value.img,
            status: user.value.bio,
          ));
      await profileString('user_profile', user.value.id);
    } on HttpException catch (e) {
      throw HttpException(e.message);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  updateUserDetails(body, bool isImg) async {
    try {
      isLoading.value = true;
      var res = isImg
          ? await _userService.changeProfileImage(File(image!.path), token)
          : await _userService.updateUserDetails(body, token);
      user.value = res;
      await _hiveController.updateProfile(
          user.value.id,
          Profile(
            id: user.value.id,
            name: user.value.name,
            number: user.value.number,
            img: user.value.img,
            status: user.value.bio,
          ));
      await profileString('user_profile', user.value.id);
      isLoading.value = false;
    } on HttpException catch (e) {
      isLoading.value = false;
      throw HttpException(e.message);
    } catch (e) {
      print(e);
      isLoading.value = false;
      throw e;
    }
  }

  messageDialogue(Widget title, Widget content, action, double elevation,
      Color bgColor, BuildContext context) {
    print('here');
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: title, // To display the title it is optional
            content: content, // Message which will be pop up on the screen
            // Action widget which will provide the user to acknowledge the choice
            actions: action,
            elevation: elevation,
            backgroundColor: bgColor,
          );
        });
  }

  snackBar(String message) {
    return SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Okay',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
  }

  contactPermissionCheckup() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) contactPermission.value = true;
  }

  requestContactPermission() async {
    if (await Permission.contacts.request().isGranted) {
      contactPermission.value = true;
    }
  }

  fetchOfflineUser() async {
    try {
      String? id = await getProfileString('user_profile');
      Profile profile = await _hiveController.getProfile(id);
      user.value = User(
        id: profile.id,
        bio: profile.status,
        img: profile.img,
        name: profile.name,
        number: profile.number,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<String?> getProfileString(key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString(key);
      return id;
    } catch (e) {
      throw e;
    }
  }

  showLoading() {
    isLoading.toggle();
  }

  hideLoading() {
    isLoading.toggle();
  }
}
