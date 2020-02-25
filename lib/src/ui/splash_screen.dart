import 'package:flutter/material.dart';
import 'package:cartech_app/src/resources/utils.dart';

class SplashScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset("asset/logo_1.png"),
    );
  }

  @override
  void initState() {
    super.initState();
    final logged = Utils.isLogged().then( (value) {
      if(value){
        Navigator.of(context).pushReplacementNamed('/main_screen');
      }else
        Navigator.of(context).pushReplacementNamed('/login_screen');
    });
  }
}