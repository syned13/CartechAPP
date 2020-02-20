import 'package:flutter/material.dart';

import 'package:cartech_app/src/ui/theme_resources.dart';

class LoginScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }

}

class LoginScreenState extends State<LoginScreen>{

  Widget _emailField() {
    return Container(
      child: TextField(
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
    return InkWell(
      onTap: (){

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

  Widget _signUpButton(){
    return InkWell(
      onTap: (){

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


}