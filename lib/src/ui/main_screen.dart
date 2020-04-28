import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:cartech_app/src/ui/orders_list.dart';
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