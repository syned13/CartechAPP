import 'package:cartech_app/src/blocs/services_screen_bloc.dart';
import 'package:cartech_app/src/models/service_category.dart';
import 'package:cartech_app/src/models/services_state.dart';
import 'package:cartech_app/src/ui/select_service_location_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {


  ServiceCategory serviceCategory;

  @override
  ServicesScreenState createState() => ServicesScreenState();

  ServicesScreen(this.serviceCategory);
}

class ServicesScreenState extends State<ServicesScreen>{

  List<Widget> _serviceCategoriesCardList(List<Service> services){
    List<Widget> cards = List();

    for(int i = 0; i < services.length; i++){
      cards.add( InkWell(
        onTap: (){Navigator.push( (context), MaterialPageRoute(builder: (context) => SelectServiceLocationScreen(services[i])));},
        child: Card(
          color: Colors.blue[200],
          child: Container(
            width: double.maxFinite,
            alignment: Alignment.center,
            height: 40,
            padding: EdgeInsets.all(5),
              child: Text(services[i].serviceName, textAlign: TextAlign.center, style: TextStyle(fontSize: 17),),),
        ),
      ));
    }

    return cards;
  }

  Widget _ServicesList(List<Service> services){
      return Container(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Elija un servicio a solicitar", style: TextStyle(fontSize: 20),),
            SizedBox(height: 20,),
            Column(children: _serviceCategoriesCardList(services),)
          ],
        ),
      );
  }

  ServicesScreenBloc servicesScreenBloc = ServicesScreenBloc();
  @override
  Widget build(BuildContext context) {
    servicesScreenBloc.getServices(widget.serviceCategory.serviceCategoryId);

    return Scaffold(
      appBar: AppBar(title: Text(widget.serviceCategory.serviceCategory),),
      body: StreamBuilder<ServicesState>(
        stream: servicesScreenBloc.servicesStateStream,
        builder: (context, snapshot) {
          if(snapshot.data is ServicesStateLoading){
            return Center(child: CircularProgressIndicator());
          }

          if(snapshot.data is ServicesStateReady){
            ServicesStateReady servicesStateReady = snapshot.data;
            return _ServicesList(servicesStateReady.services);
          }

          return Container();
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

    servicesScreenBloc.servicesStateStream.listen( (data){
      if(data is ServicesStateError){
        _showDialog(data.errorMessage);
      }
    });
  }
}