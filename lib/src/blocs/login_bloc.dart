
import 'dart:convert';

import 'package:cartech_app/src/blocs/bloc.dart';
import 'package:cartech_app/src/models/login_state.dart';
import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/api_client.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  BehaviorSubject<LoginState> _loginStateController = BehaviorSubject();

  Stream<LoginState> get loginStateStream => _loginStateController.stream.asBroadcastStream();


  void submit() async{
    _loginStateController.sink.add(LoginStateLoading());

    User user = User();
    user.email = emailController.text;
    user.password = passwordController.text;

    String responseBody = await ApiClient.postUser(user, "/login").catchError( (error){
      _loginStateController.sink.add( LoginStateError(error.toString()));
      return;
    });

    Map<String, dynamic> responseMap = json.decode(responseBody);

    Utils.saveInfo(responseMap);

    _loginStateController.sink.add(LoginStateReady());

  }
  @override
  void dispose() {
  _loginStateController.close();
  }
}