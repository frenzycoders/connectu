import 'package:connectu/core/controllers/hiveController.dart';
import 'package:get/get.dart';

class HiveBinding extends Bindings {
  @override
  void dependencies() {
    print('Binding Hive Database...');
    // TODO: implement dependencies
    Get.put(HiveController());
  }
}
