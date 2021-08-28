import 'dart:convert';

import 'package:connectu/core/models/user.model.dart';
import 'package:connectu/service/user/user_service.dart';
import 'package:connectu/service/http/http_exception.dart';
import 'package:connectu/service/http/http_service.dart';
import 'package:connectu/service/http/http_service_impl.dart';
import 'package:get/get.dart';

class UserServiceImpl implements UserService {
  late HttpService _httpService;

  UserServiceImpl() {
    _httpService = Get.put(HttpImpl());
    _httpService.init();
  }

  @override
  Future<User> joinUser(String number, var countryCode) async {
    try {
      final response = await _httpService.postRequest(
          'user/join-user', {}, {"number": number, "countryCode": countryCode});
      if (response.statusCode != 200) throw HttpException('Server error.');
      User user = User.fromJson(jsonDecode(response.body)['user']);
      return user;
    } catch (e) {
      throw e;
    }
  }
}
