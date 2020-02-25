import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkOnProgressScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Todavia esta funcionalidad no esta disponible, per muy pronto lo estara!",
              textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),),
            SizedBox(height: 30,),
            Container(child: Image.asset("assets/logo_1.png"), height: 100,),
          ],
        ),
      ),
    );
  }
}