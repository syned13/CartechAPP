import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/push_notification.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:cartech_app/src/ui/orders_list_screen.dart';
import 'package:cartech_app/src/ui/profile_screen.dart';
import 'package:cartech_app/src/ui/services_categories_screen.dart';
import 'package:cartech_app/src/ui/theme_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen>{

  int _currentIndex = 0;
  List<Widget> _children = [ServicesCategoriesScreen(), OrdersListScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {

    PushNotificationsManager.setOnMessage(onMessageHandler);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        backgroundColor: Color.fromRGBO(27, 130, 226, 100),
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            title: Text("Sevicios"),
            icon: Icon(Icons.build),
          ),
          BottomNavigationBarItem(
              title: Text("Órdenes"),
              icon: Icon(Icons.shopping_cart)
          ),
          BottomNavigationBarItem(
            title: Text("Perfil"),
            icon: Icon(Icons.account_box),
          ),
        ],
      ),

      body: _children[_currentIndex],
    );
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

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }
}