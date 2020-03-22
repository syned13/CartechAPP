import 'dart:convert';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cartech_app/src/models/user.dart';
import 'dart:developer' as developer;

class ApiClient {

  static final String API_ENDPOINT = "https://api-cartech.herokuapp.com";
//static final String API_ENDPOINT = "http://10.0.2.2:5000";

  static Future<String> postUser(User user, String path) async {
    Map<String, String> headers = Map();
    headers["content-type"] = "application/json";
    Map<String, dynamic> bodyMap = user.toJson();

    String body = jsonEncode(bodyMap);

    try {
      final response = await http.post(
          API_ENDPOINT + path, headers: headers, body: body).catchError( (error) {
        return Future.error(error);
      }).timeout(Duration(milliseconds: 10000));

      if (response == null) {
        return Future.error("request error");
      }

      developer.log("response: " + response.body);
      if (response.statusCode != 200) {
        developer.log("invalid_status_code: " + response.statusCode.toString());
        String errorMessage = jsonDecode(response.body)["message"];
        return Future.error(errorMessage);
      }


      return utf8.decode(response.bodyBytes);
    }

    catch (Exception) {
      return Future.error(Exception.toString());
    }

    return "";
  }


  static Future<String> get(String token, String path) async {
    Map<String, String> headers = Map();
    headers["content-type"] = "application/json";
    headers["Authorization"] = token;


    try {
      final response = await http.get(
          API_ENDPOINT + path, headers: headers).catchError( (error) {
        return Future.error(error);
      }).timeout(Duration(milliseconds: 10000));

      if (response == null) {
        return Future.error("request error");
      }


      if (response.statusCode != 200) {
        String errorMessage = jsonDecode(response.body)["message"];
        return Future.error(errorMessage);
      }

      developer.log(response.body);
      return utf8.decode(response.bodyBytes);
    }

    catch (Exception) {
      return Future.error(Exception.toString());
    }

    return "";
  }
}