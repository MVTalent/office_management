import 'package:office_management/model/user.dart';

abstract class SharedStorage {
  Future<User> getUserFromStorage();
}