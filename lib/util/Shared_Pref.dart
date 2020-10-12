import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTest {
  static final String userId = "userId";
  static final String userType = "userType";
  static final String userName = "userName";

  static Future<String> getUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(userId) ?? 'null';
  }

 static Future<bool> setUserID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(userId, value);
  }

  static Future<String> getuserType(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(userType) ?? 'null';
  }

 static Future<bool> setuserType(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(userType, value);
  }

  static Future<String> geuserName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(userName) ?? 'null';
  }

 static Future<bool> setuserName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(userName, value);
  }

  static remove() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}