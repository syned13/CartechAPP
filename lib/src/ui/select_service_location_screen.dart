import 'package:cartech_app/src/blocs/select_service_location_bloc.dart';
import 'package:cartech_app/src/models/select_service_location_state.dart';
import 'package:cartech_app/src/models/service_category.dart';
import 'package:cartech_app/src/models/service_request.dart';
import 'package:cartech_app/src/ui/confirm_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:cartech_app/src/ui/theme_resources.dart';

class SelectServiceLocationScreen extends StatefulWidget{
  Service service;

  SelectServiceLocationScreen(this.service);

  @override
  State<StatefulWidget> createState() {
    return SelectServiceLocationScreenState();
  }

}

class SelectServiceLocationScreenState extends State<SelectServiceLocationScreen>{
  GoogleMapController mapController;

  final zoom = 20.0;
  SelectServiceLocationBloc bloc = SelectServiceLocationBloc();

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }

  Future<LatLng> getLocationMarkerCoordinates() async {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double middleX = screenWidth / 2;
    double middleY = screenHeight / 2;

    ScreenCoordinate screenCoordinate = ScreenCoordinate(x: middleX.round(), y: middleY.round());

    LatLng middlePoint = await mapController.getLatLng(screenCoordinate);

    return middlePoint;
  }

  @override
  Widget build(BuildContext context) {
    bloc.getInitialLocation();

    return Scaffold(
      body: StreamBuilder<SelectServiceLocationState>(
        stream: bloc.selectServiceStateStream,
        builder: (context, snapshot) {
          if(snapshot.data is SelectServiceLocationStateLoading){
            return Center(child: CircularProgressIndicator(),);
          }

          if(snapshot.data is SelectServiceLocationStateReady){
            SelectServiceLocationStateReady readyState = snapshot.data;

            return Stack(
                children: <Widget>[
                  GoogleMap(
                    myLocationButtonEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(readyState.position.latitude, readyState.position.longitude),
                      zoom: zoom,
                    ),
                  ),

                  Positioned(
                      top: 50,
                      right: 20,
                      left: 20,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text("¿Dónde quieres tu servicio?", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                        decoration: BoxDecoration(
                          color: Resources.SecondaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),)
                  ),

                  Positioned(
                    top: 100,
                    left: 20,
                    child: Container(
                      alignment: Alignment.center,
                      child: OutlineButton.icon(
                        icon: Icon(Icons.my_location),
                        label: Text("Mi ubicacion"),
                        onPressed: (){_getLocation();},
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 30,
                    right: 30,
                    left: 30,
                    child: RaisedButton(
                      color: Resources.MainColor,
                      onPressed: () async {
                        final serviceLocation = await getLocationMarkerCoordinates();
                        ServiceRequest serviceRequest = ServiceRequest();
                        serviceRequest.service = widget.service;
                        serviceRequest.serviceLocation = serviceLocation;

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmServiceScreen(serviceRequest)));
                      },
                      child: Container(
                          color: Resources.MainColor,
                          child: Text("Confirmar ubicacion")),
                    ),
                  ),

                  Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Image(
                          image: AssetImage("assets/marker.png"),
                        ),
                      )
                  )
                ]
            );
          }

          return Container();

        }
      ),
    );
  }

  void _getLocation() async {
    Position currentLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      mapController.moveCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: zoom)
          )
      );
    }
}