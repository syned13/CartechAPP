import 'package:cartech_app/src/blocs/services_screen_bloc.dart';
import 'package:cartech_app/src/models/services_state.dart';
import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:cartech_app/src/ui/theme_resources.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return ServicesScreenState();
  }

}


class ServicesScreenState extends State<ServicesScreen>{

  MainScreeBloc mainScreeBloc = MainScreeBloc();

  @override
  Widget build(BuildContext context) {
    mainScreeBloc.init();

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<ServicesState>(
          stream: mainScreeBloc.servicesStateStream,
          builder: (context, snapshot) {
            if(snapshot.data is ServicesStateLoading){
              return CircularProgressIndicator();
            }

            else if(snapshot.data is ServicesStateReady){
              ServicesStateReady data = snapshot.data;

              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text("Hola, " + data.user.name.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Theme.of(context).accentColor),),
                  ],
                ),
              )  ;
            }

            return Text("Hola");
          }
        ),
      ),
    );

  }

  @override
  void initState() {
    super.initState();

  }
}