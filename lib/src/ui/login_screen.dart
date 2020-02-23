
import 'package:cartech_app/src/blocs/login_bloc.dart';
import 'package:cartech_app/src/models/login_state.dart';
import 'package:cartech_app/src/ui/main_screen.dart';
import 'package:cartech_app/src/ui/sign_up_screen.dart';
import 'package:flutter/material.dart';

import 'package:cartech_app/src/ui/theme_resources.dart';

class LoginScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }

}

class LoginScreenState extends State<LoginScreen>{

  LoginBloc loginBloc = LoginBloc();

  Widget _emailField() {
    return Container(
      child: TextField(
        controller: loginBloc.emailController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Resources.MainColor)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Resources.MainColor),),
          border: OutlineInputBorder(borderSide: BorderSide(color: Resources.MainColor),),
          hintText: "Correo electronico",
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      child: TextField(
        controller: loginBloc.passwordController,
        obscureText: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Resources.MainColor)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Resources.MainColor) ),
          border: OutlineInputBorder(borderSide: BorderSide(color: Resources.MainColor)),
          hintText: "Contrasena",
          filled: false,
        ),
      ),
    );
  }

  Widget _loginButton(){
    return StreamBuilder<LoginState>(
      stream: loginBloc.loginStateStream,
      builder: (context, snapshot) {
        if(snapshot.data is LoginStateLoading){
          return CircularProgressIndicator();
        }

        return InkWell(
          onTap: (){
            loginBloc.submit();
          },
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
              width: MediaQuery.of(context).size.width/3,
            child: Text("Ingresar", style: TextStyle(color: Colors.grey[100]),),
            decoration: BoxDecoration(
              color: Resources.MainColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        );
      }
    );
  }

  Widget _signUpButton(){
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width/4,
        child: Text("Registrarse", style: TextStyle(color: Colors.grey[100]),),
        decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Image(image: AssetImage("assets/logo_1.png"),
              width: 200,),
              SizedBox(height: 30,),
              _emailField(),
              SizedBox(height: 20,),
              _passwordField(),
              SizedBox(height: 30,),
              _loginButton(),
              SizedBox(height: 50,),
              Text("¿No tienes cuenta?"),
              SizedBox(height: 5,),
              _signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    loginBloc.loginStateStream.listen( (data) {
      if(data is LoginStateError){
        _showDialog(data.errorMessage);
      }
      else if(data is LoginStateReady){
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => MainScreen()));
      }
    });

  }

}