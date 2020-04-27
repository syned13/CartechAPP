
import 'dart:convert';

import 'package:cartech_app/src/blocs/bloc.dart';
import 'package:cartech_app/src/models/login_state.dart';
import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/api_client.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:developer' as developer;

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
      developer.log("error_while_posting_user: " + error.toString());
      String errorMessage = error.toString();
      if(errorMessage == "missing email" || errorMessage == "missing password"){
        errorMessage = "Datos faltantes";
      }
      else if(errorMessage == "incorrect email or password"){
        errorMessage = "Correo o contraseña incorrecta";
      }
      else{
        errorMessage = "Error inesperado";
      }

      _loginStateController.sink.add(LoginStateError(errorMessage));
      return;
    });

    Map<String, dynamic> responseMap = json.decode(responseBody);

    try{
      bool result = await Utils.saveLoginInfo(responseMap);
      if(!result){
        _loginStateController.sink.add(LoginStateError("some error"));
      }
    }
    catch (Exception){
      _loginStateController.sink.add(LoginStateError(Exception.toString()));
      return;
    }

    _loginStateController.sink.add(LoginStateReady());
  }

  @override
  void dispose() {
  _loginStateController.close();
  }
}