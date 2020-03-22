import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:cartech_app/src/ui/orders_list.dart';
import 'package:cartech_app/src/ui/profile_screen.dart';
import 'package:cartech_app/src/ui/services_categories_screen.dart';
import 'package:cartech_app/src/ui/theme_resources.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen>{

  int _currentIndex = 0;
//  List<String> _appbarTitles = ["Areas", "Reservas", "Perfil"];
  List<Widget> _children = [ServicesCategoriesScreen(), OrdersListSreen(), ProfileScreen()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        backgroundColor: Resources.MainColor,
        items: [
          BottomNavigationBarItem(
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