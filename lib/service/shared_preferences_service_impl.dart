import 'package:office_management/model/user.dart';
import 'package:office_management/service/shared_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorageImpl implements SharedStorage {

  @override
  Future<User> getUserFromStorage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userName = preferences.getString("LastUserName");
    String userToken = preferences.getString("LastToken");
    String userEmail = preferences.getString("LastEmail");
    String userId = preferences.getString("LastUserId");
    return User(userName, userToken, userEmail, userId);
  }

}