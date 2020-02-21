import 'package:cartech_app/src/blocs/bloc.dart';
import 'package:cartech_app/src/models/sign_up_state.dart';
import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io';


class SignUpBloc extends Bloc {

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  BehaviorSubject<SignUpState> _signUpStateController = BehaviorSubject();

  Stream<SignUpState> get signUpStateStream => _signUpStateController.stream.asBroadcastStream();

  String errorMessage = "";

  void signUp() async {
    if(nameController.text == "" || lastNameController.text == "" || emailController.text == "" || phoneNumberController.text == "" || passwordController.text == ""){
      _signUpStateController.sink.add(SignUpStateError("Datos faltantes"));
      return;
    }

    User user = User();
    user.name = nameController.text;
    user.lastName = lastNameController.text;
    user.email = emailController.text;
    user.phoneNumber = phoneNumberController.text;
    user.password = passwordController.text;

    _signUpStateController.sink.add(new SignUpStateLoading());

    String response = await ApiClient.signUp(user).catchError( (error) {
      String errorMessage = error.toString();

      if(errorMessage == "email must be unique"){
        errorMessage = "Correo electronico debe ser unico";
      }
      else{
        errorMessage = "Ha ocurrido un error";
      }

      _signUpStateController.sink.add(SignUpStateError(errorMessage));
      return;
    });

    _signUpStateController.sink.add(new SignUpStateDone());
  }


  @override
  void dispose() {
    _signUpStateController.close();
  }
}