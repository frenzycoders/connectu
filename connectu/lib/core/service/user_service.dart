import 'dart:io';

import 'package:connectu/core/models/user.model.dart';

abstract class UserService {
  Future<User> joinUser(String number, var countryCode);
  Future resendOtp(number);
  Future<String> getVerifiedAndToken(number, id, otp);
  Future<User> tokenBasedAuthentication(token);
  Future<User> updateUserDetails(body, token);
  Future<User> changeProfileImage(File images, token);
  Future<User> fetchUserById(String id, String token);
}
