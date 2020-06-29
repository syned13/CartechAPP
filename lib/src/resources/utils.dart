import 'dart:convert';

import 'package:cartech_app/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static const GOOGLE_MAP_KEY = "AIzaSyCJyJ3arrtyEjrwvWxpdv5axJVN3SJFLzg";

  static Future<bool> saveLoginInfo(Map<String, dynamic> userInfo) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("TOKEN", userInfo["token"]);

    User user = User.fromJson(userInfo);
    bool result;
    result = await sharedPreferences.setString("NAME", user.name);
    if (!result) {
      return false;
    }

    result = await sharedPreferences.setString("LAST_NAME", user.name);
    if (!result) {
      return false;
    }

    result = await sharedPreferences.setString("EMAIL", user.email);
    if (!result) {
      return false;
    }

    result =
        await sharedPreferences.setString("PHONE_NUMBER", user.phoneNumber);
    if (!result) {
      return false;
    }

    return sharedPreferences.setInt("USER_ID", user.userID);
  }

  static String decodeResponse(String responseBody) {
    var encoded = utf8.encode(responseBody);
    var decoded = utf8.decode(encoded);

    return decoded;
  }

  static Future<User> getLoggedUserInfo() async {
    User user = User();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    user.name = sharedPreferences.getString("NAME");
    user.lastName = sharedPreferences.getString("LAST_NAME");
    user.email = sharedPreferences.getString("EMAIL");
    user.phoneNumber = sharedPreferences.getString("PHONE_NUMBER");
    user.userID = sharedPreferences.getInt("USER_ID");

    return user;
  }

  static Future<bool> isLogged() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("TOKEN");

    if (token == null) return false;

    return true;
  }

  static void logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("TOKEN");
    sharedPreferences.remove("NAME");
    sharedPreferences.remove("LAST_NAME");
    sharedPreferences.remove("USER_ID");
    sharedPreferences.remove("PHONE_NUMBER");
    sharedPreferences.remove("EMAIL");
  }

  static void saveFCMToken(String token) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("FCM_TOKEN", token);
  }

  static Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String returnedToken = sharedPreferences.getString("TOKEN");

    return returnedToken;
  }
}
