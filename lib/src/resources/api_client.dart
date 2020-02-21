import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cartech_app/src/models/user.dart';
import 'dart:developer' as developer;

class ApiClient {

  static final String API_ENDPOINT = "https://api-cartech.herokuapp.com";

  static Future<String> signUp(User user) async {
    Map<String, String> headers = Map();
    headers["content-type"] = "application/json";
    Map<String, dynamic> bodyMap = user.toJson();

    String body = jsonEncode(bodyMap);

    try {
      final response = await http.post(
          API_ENDPOINT + "/signup", headers: headers, body: body).catchError( (error) {
        return Future.error(error);
      }).timeout(Duration(milliseconds: 10000));

      if (response == null) {
        return Future.error("request error");
      }

      if (response.statusCode != 200) {
        String errorMessage = jsonDecode(response.body)["message"];
        return Future.error(errorMessage);
      }

      return response.body;
    }

    catch (Exception) {
      return Future.error(Exception.toString());
    }

    return "";
  }
}