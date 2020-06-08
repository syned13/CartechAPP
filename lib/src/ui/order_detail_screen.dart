import 'package:cartech_app/src/blocs/orders/order_detail_bloc.dart';
import 'package:cartech_app/src/models/service_order.dart';
import 'package:cartech_app/src/states/orders/order_detail_state.dart';
import 'package:cartech_app/src/ui/shared.dart';
import 'package:cartech_app/src/ui/theme_resources.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderDetailScreen extends StatefulWidget {
  ServiceOrder order;

  OrderDetailScreen(this.order);

  State createState() {
    return OrderDetailsScreenState();
  }
}

class OrderDetailsScreenState extends State<OrderDetailScreen> {
  Set<Marker> _markers = Set();
  OrderDetailBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(
      markerId: MarkerId("order_location"),
      position: LatLng(widget.order.lat, widget.order.lng),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de la orden"),
      ),
      body: Container(
        child: StreamBuilder<OrderDetailState>(
          stream: _bloc.orderDetailStream,
          builder: (context, snapshot) {

            return Column(
              children: <Widget>[
                Container(
                  height: 150,
                  child: GoogleMap(
                    scrollGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.order.lat, widget.order.lng),
                      zoom: 30,
                    ),
                  ),
                ),
                Divider(
                  height: 30,
                  color: Colors.black,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(Shared.getDayFromDate(widget.order.createdAt) +
                              " a las " +
                              Shared.getHourFromDate(widget.order.createdAt)),
                          Spacer(),
                          Text("RD\$125.55")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Servicio solicitado: ${widget.order.serviceName}"),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Estado de la orden: ${Shared.parseOrderStatus(widget.order.status)}"),
                      SizedBox(height: 20,),
                      Container(
                        alignment: Alignment.center,
                        child: snapshot.data is OrderDetailStateLoading?CircularProgressIndicator():RaisedButton(
                          color: Colors.red[200],
                          onPressed: () async {_bloc.cancellOrder();},
                          child: Text("Cancelar orden"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        ),
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
              child: new Text("Cerrar"),
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
    _bloc = OrderDetailBloc(widget.order);
    _bloc.orderDetailStream.listen((data){
      if(data is OrderDetailStateError){
        _showDialog(data.errorMessage);
      }
      if(data is OrderDetailsStateCancelledDone){
        Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          message: "Orden cancelada con éxito",
          icon: Icon(
            Icons.check,
            size: 28.0,
            color: Resources.SecondaryColor,
          ),
          backgroundColor: Resources.MainColor,
          duration: Duration(seconds: 1),
          leftBarIndicatorColor: Colors.green,

        ).show(context).then( (r){
          Navigator.pop(context);
        });
      }
    });
  }
}
