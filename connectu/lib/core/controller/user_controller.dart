import 'package:connectu/service/http/http_exception.dart';
import 'package:connectu/service/user/user_service.dart';
import '../models/user.model.dart';
import 'package:connectu/service/user/user_service_impl.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserController extends GetxController {
  late UserService _userService;

  UserController() {
    _userService = Get.find<UserServiceImpl>() as UserService;
  }

  late Rx<User> user;

  joinUser() async {
    try {
      User result = await _userService.joinUser('', '+91');
      user = result.obs;
    } on HttpException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }
}
