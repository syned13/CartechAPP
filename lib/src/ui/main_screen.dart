import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainScreenState();
  }

}


class MainScreenState extends State<MainScreen>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Text("Hola"),
      ),
    );

  }
}