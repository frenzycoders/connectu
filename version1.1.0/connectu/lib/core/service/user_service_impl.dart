import 'dart:convert';
import 'dart:io';

import 'package:connectu/core/models/user.model.dart';
import 'package:connectu/core/service/user_service.dart';
import 'package:connectu/service/http/http_file.dart';
import 'package:connectu/service/http/multipart_headers.dart';
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

  @override
  Future resendOtp(number) async {
    try {
      final response =
          await _httpService.postRequest('user/resend-otp/$number', {}, {});
      if (response.statusCode != 200)
        throw HttpException(jsonDecode(response.body)['msg']);
      return jsonDecode(response.body)['msg'];
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> getVerifiedAndToken(number, id, otp) async {
    try {
      final response = await _httpService
          .postRequest('user/verify/' + number + '/' + id, {}, {"otp": otp});
      if (response.statusCode == 404)
        throw HttpException('Wrong OTP try again.');
      else
        return jsonDecode(response.body)['token'];
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<User> tokenBasedAuthentication(token) async {
    try {
      token = token == null ? 'N' : token;
      final response = await _httpService
          .getRequest('user/user-profile', {'x-user': token}, {});

      print(response.statusCode);
      if (response.statusCode == 404)
        throw HttpException('Token Expired Login again.');
      User user = User.fromJson(jsonDecode(response.body)['user']);
      return user;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<User> updateUserDetails(body, token) async {
    try {
      final response = await _httpService.patchRequest(
          'user/update-profile', {'x-user': token}, body);
      if (response.statusCode != 200) throw HttpException('Server error!');
      User user = User.fromJson(jsonDecode(response.body)['user']);
      return user;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<User> changeProfileImage(File images, token) async {
    print(images);
    try {
      final response = await _httpService.maltiPartedRequest(
          'user/update-profile',
          [HttpFile(key: 'img', image: images)],
          [MultiPartHeader(key: "x-user", value: token)],
          []);
      if (response.statusCode != 200) throw HttpException('Server error!');
      User user = User.fromJson(jsonDecode(response.body)['user']);
      return user;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<User> fetchUserById(String id, String token) async {
    try {
      final response = await _httpService
          .getRequest('user-by-id/$id', {'x-user': token}, {});
      if (response != 404) throw HttpException('User not found');
      print(response.body);
      return User();
    } catch (e) {
      throw e;
    }
  }
}
