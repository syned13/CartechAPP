import 'package:cartech_app/src/models/service_request.dart';
import 'package:cartech_app/src/ui/theme_resources.dart';
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

  @override
  Widget build(BuildContext context) {
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
            child: Column(
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
                  child: RaisedButton(
                    color: Resources.MainColor,
                    onPressed: (){},
                    child: Text("Confirmar servicio"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}