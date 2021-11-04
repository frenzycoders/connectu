import 'package:connectu/core/controllers/RTCcontroller.dart';
import 'package:connectu/core/service/rtc_service_impl.dart';
import 'package:get/get.dart';

class RTCbinding extends Bindings {
  @override
  void dependencies() {
    print('Binding Socket Controller');
    Get.put(RTCserviceImpl());
    Get.put(RTCcontroller());
  }
}
