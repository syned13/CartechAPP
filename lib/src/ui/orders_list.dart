import 'package:flutter/material.dart';

class OrdersListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Órdenes"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Actuales",),
              Tab(text: "Pasadas",),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("Todavía no tienes ordenes"),
                    ),
                  )
                ],
              ),
            ),
            Text("Hello"),
          ]
        ),
      ),
    );
  }
}