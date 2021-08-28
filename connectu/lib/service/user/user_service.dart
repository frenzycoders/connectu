
import 'package:connectu/core/models/user.model.dart';

abstract class UserService {
  Future<User> joinUser(String number, var countryCode);
}
