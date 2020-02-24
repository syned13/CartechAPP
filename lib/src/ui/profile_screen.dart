
import 'package:cartech_app/src/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("Cerrar sesion"),
                onPressed: (){
                  Utils.logOut();
                  Navigator.of(context).pushReplacementNamed('/login_screen');
                },
              )
            ],
          ),
        ),
      ),
    );

  }
}