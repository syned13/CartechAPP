import 'package:flutter/material.dart';

class OrdersListSreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Tus órdenes de servicio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text("Todavía no tienes ordenes"),
              ),
            )
          ],
        ),
      ),
    );
  }
}