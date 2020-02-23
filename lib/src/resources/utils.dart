import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:developer' as developer;

class Utils{


  static void saveInfo(Map<String, dynamic> userInfo) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("TOKEN", userInfo["token"]);
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