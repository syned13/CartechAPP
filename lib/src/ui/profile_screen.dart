
import 'package:cartech_app/src/blocs/profile_screen_bloc.dart';
import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:cartech_app/src/ui/theme_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget{

  final ProfileScreenBloc profileScreenBloc = ProfileScreenBloc();

  @override
  Widget build(BuildContext context) {
    profileScreenBloc.getUser();

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<User>(
          stream: profileScreenBloc.userStream,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }

            return Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
              Text( snapshot.data.name + " " + snapshot.data.lastName),
                  SizedBox(height: 10,),
                  Text("Correo electronico: " + snapshot.data.email),
                  SizedBox(height: 10,),
                  Text("Número telefónico: " + snapshot.data.phoneNumber),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Utils.logOut();
                      Navigator.of(context).pushReplacementNamed('/login_screen');
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width/3,
                      child: Text("Cerrar sesión", ),
                      decoration: BoxDecoration(
                        color: Resources.MainColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );

  }


}