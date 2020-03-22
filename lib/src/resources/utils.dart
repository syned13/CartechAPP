import 'dart:convert';

import 'package:cartech_app/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:developer' as developer;

class Utils{

  static const GOOGLE_MAP_KEY = "AIzaSyCJyJ3arrtyEjrwvWxpdv5axJVN3SJFLzg";

  static void saveLoginInfo(Map<String, dynamic> userInfo) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("TOKEN", userInfo["token"]);

    User user = User.fromJson(userInfo);
    sharedPreferences.setString("NAME", user.name);
    sharedPreferences.setString("LAST_NAME", user.name);
    sharedPreferences.setString("EMAIL", user.email); 
    sharedPreferences.setString("PHONE_NUMBER", user.phoneNumber);

  }

  static String decodeResponse(String responseBody){
    var encoded = utf8.encode(responseBody);
    var decoded = utf8.decode(encoded);

    return decoded;
  }

  static Future<User> getLoggedUserInfo() async{
    User user = User();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    user.name = sharedPreferences.getString("NAME");
    user.lastName = sharedPreferences.getString("LAST_NAME");
    user.email = sharedPreferences.getString("EMAIL");
    user.phoneNumber = sharedPreferences.getString("PHONE_NUMBER");

    return user;
  }

  static Future<bool>  isLogged() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("TOKEN");

    if (token == null)
      return false;

    return true;
  }

  static void logOut() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("TOKEN");
    sharedPreferences.remove("FULL_NAME");
    sharedPreferences.remove("PROGRAM");
  }

  static Future<String> getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String returnedToken =  sharedPreferences.getString("TOKEN");

    return returnedToken;

  }

}