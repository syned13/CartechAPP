import 'package:cartech_app/src/blocs/confirm_service_screen_bloc.dart';
import 'package:cartech_app/src/models/service_request.dart';
import 'package:cartech_app/src/states/confirm_service_state.dart';
import 'package:cartech_app/src/ui/theme_resources.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConfirmServiceScreen extends StatefulWidget{

  final ServiceRequest serviceRequest;

  ConfirmServiceScreen(this.serviceRequest);

  @override
  State<StatefulWidget> createState() {
    return ConfirmServiceScreenState();
  }
}

class ConfirmServiceScreenState extends State<ConfirmServiceScreen>{

  Set<Marker> _markers = Set();
  ConfirmServiceScreenBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc.init();
    _markers.add(Marker(
      markerId: MarkerId("service_location"),
      position: widget.serviceRequest.serviceLocation,
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmar servicio"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: StreamBuilder<ConfirmServiceState>(
              stream: _bloc.confirmServiceStream,
              builder: (context, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Detalles del servicio solicitado "),
                    SizedBox(height: 25,),
                    Text("Servicio solicitado: " + widget.serviceRequest.service.serviceName),
                    SizedBox(height: 10,),
                    Text("Precio base: 600"),
                    SizedBox(height: 10,),
                    Text("Ubicacion del servicio: "),
                    SizedBox(height: 5,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color:Colors.grey[500])
                      ),
                      height: 200,
                      width: 200,
                      child: GoogleMap(
                        markers: _markers,
                        initialCameraPosition: CameraPosition(
                          target: widget.serviceRequest.serviceLocation,
                          zoom: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          helperText: "Nota para el/la mecanico/a"
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        maxLength: 60,
                      ),
                    ),
                    SizedBox(height: 60,),
                    Container(
                      alignment: Alignment.center,
                      child: (snapshot.data is ConfirmServiceStateLoading ) ? CircularProgressIndicator() : RaisedButton(
                        color: Resources.MainColor,
                        onPressed: (){
                          _bloc.confirmServiceRequest();
                        },
                        child: Text("Confirmar servicio"),
                      ),
                    )
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(String title, String message, Function next) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                next();
              },
            ),
          ],
        );
      },
    );
  }

  void _goToFirstScreen(){
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _closeDialog(){
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    this._bloc = ConfirmServiceScreenBloc(widget.serviceRequest);
    _bloc.confirmServiceStream.listen( (data){
      if(data is ConfirmServiceStateError){
        _showDialog("Error", data.errorMessage, _closeDialog);
      }
      else if(data is ConfirmServiceStateDone){
        _showDialog("Orden procesada", "Tu orden ha sido procesada. Puedes ver el estado de la misma en el apartado de ordenes.", _goToFirstScreen);
      }
    });
  }
}