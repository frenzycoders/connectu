import 'package:connectu/core/controllers/contactController.dart';
import 'package:connectu/core/service/contactServiceImpl.dart';
import 'package:get/get.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    print('Binding Contact Controller');
    Get.put(ContactServiceImpl());
    Get.put(ContactController());
  }
}
