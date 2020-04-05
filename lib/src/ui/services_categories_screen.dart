import 'package:cartech_app/src/blocs/services_categories_screen_bloc.dart';
import 'package:cartech_app/src/models/service_category.dart';
import 'package:cartech_app/src/models/services_categories_state.dart';
import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:cartech_app/src/ui/services_screen.dart';
import 'package:cartech_app/src/ui/work_on_progress_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServicesCategoriesScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return ServicesCategoriesScreenState();
  }

}


class ServicesCategoriesScreenState extends State<ServicesCategoriesScreen>{

  Map<String, Widget> categoriesImages = {
    "Frenos": SvgPicture.asset("assets/brake.svg", height: 50,),
    "Afinación de motor": SvgPicture.asset("assets/motor.svg", height: 50,),
    "Cambio de aceite y lubricación": SvgPicture.asset("assets/oil.svg", height: 50,),
    "Mantenimiento de suspensión": SvgPicture.asset("assets/suspension.svg", height: 50,),
    "Revisión eléctrica": SvgPicture.asset("assets/flash.svg", height: 50,),
    "Default": SvgPicture.asset("assets/tool.svg", height: 50,),
  };

  Widget _getCategoryImage(String categoryName){
    if(categoriesImages.containsKey(categoryName)){
      return categoriesImages[categoryName];
    }

    return categoriesImages["default"];
  }
  
  ServicesCategoriesScreenBloc servicesScreenBloc = ServicesCategoriesScreenBloc();

  List<Widget> _serviceCategoriesCardList(List<ServiceCategory> serviceCategories){
    List<Widget> cards = List();

    for(int i = 0; i < serviceCategories.length; i++){
      cards.add( InkWell(
        onTap: (){
          Navigator.push( (context), MaterialPageRoute(builder: (context) => ServicesScreen(serviceCategories[i])));
        },
        child: Card(
          color: Colors.deepPurple[100],
          child: Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _getCategoryImage(serviceCategories[i].serviceCategory),
                  SizedBox(height: 5,),
                  Text(serviceCategories[i].serviceCategory, textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
        ),
      ));
    }

    return cards;
  }

  Widget _servicesGridView(List<ServiceCategory> serviceCategories){
    return GridView.count(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        primary: false,
        crossAxisSpacing: 5.0,
        crossAxisCount: 2,
        children: _serviceCategoriesCardList(serviceCategories),
    );
  }

  @override
  Widget build(BuildContext context) {
    servicesScreenBloc.init();

    return Scaffold(
      body: StreamBuilder<ServicesCategoriesState>(
        stream: servicesScreenBloc.servicesStateStream,
        builder: (context, snapshot) {
          if(snapshot.data is ServicesCategoriesStateLoading){
            return Container(
                alignment:Alignment.center,child: CircularProgressIndicator());
          }

          else if(snapshot.data is ServicesCategoriesStateReady){
            ServicesCategoriesStateReady data = snapshot.data;

            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Hola, " + data.user.name.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Theme.of(context).accentColor),),
                      SizedBox(height: 5,),
                      Text("¿Qué necesitas?", style: TextStyle(fontSize: 20),),
                      SizedBox(height: 20,),
                      Text("Categorías de servicios", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
                      _servicesGridView(data.serviceCategories),

                    ],
                  ),
                ),
              ),
            )  ;
          }

          return Text("Hola");
        }
      ),
    );

  }

  void _showDialog(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();

    servicesScreenBloc.servicesStateStream.listen( (data) {
      if(data is ServicesCategoriesStateError){
        _showDialog(data.errorMessage);
      }
    });
  }
}