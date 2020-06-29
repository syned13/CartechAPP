import 'package:cartech_app/src/resources/push_notification.dart';
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
    PushNotificationsManager.init(onMessageHandler);
    return Container(
      child: Image.asset("assets/logo_1.png"),
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

  void onMessageHandler(Map<String, dynamic> message) {
    _showDialog(
        message['notification']['title'], message['notification']['body']);
    print("HERE");
  }

  void _showDialog(String message, String body) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(message),
          content: new Text(body),
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
}