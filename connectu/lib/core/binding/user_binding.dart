import 'package:connectu/core/controller/user_controller.dart';
import 'package:connectu/service/user/user_service_impl.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserServiceImpl());
    Get.put(UserController());
  }
}
