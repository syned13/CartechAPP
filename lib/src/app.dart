import 'package:flutter/material.dart';
import 'package:cartech_app/src/ui/splash_screen.dart';
import 'package:cartech_app/src/ui/main_screen.dart';
import 'package:cartech_app/src/ui/login_screen.dart';

import 'dart:developer' as developer;


class CartechApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservatec',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          secondaryHeaderColor: Colors.redAccent
      ),
      home: SplashScreen(),
      routes: <String,WidgetBuilder>{
        '/main_screen': (BuildContext context) => new MainScreen(),
        '/login_screen': (BuildContext context) => new LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}