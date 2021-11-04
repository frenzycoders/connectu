import 'package:connectu/core/controllers/user_controller.dart';
import 'package:connectu/core/service/user_service_impl.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    print('Bindig UserController...');
    Get.put(UserServiceImpl());
    Get.put(UserController());
  }
}
