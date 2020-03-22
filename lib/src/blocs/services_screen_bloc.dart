import 'package:cartech_app/src/models/service_category.dart';
import 'package:cartech_app/src/models/services_state.dart';
import 'package:cartech_app/src/resources/api_client.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';
import 'dart:convert';
import 'dart:developer' as developer;

class ServicesScreenBloc extends Bloc{

  BehaviorSubject<ServicesState> _servicesStateController = BehaviorSubject();

  Stream<ServicesState>  get servicesStateStream => _servicesStateController.stream.asBroadcastStream();

  void getServices(int serviceCategoryID) async {
    _servicesStateController.sink.add(ServicesStateLoading());

    String token = await Utils.getToken();
    String path = "/service/category/" + serviceCategoryID.toString();
    developer.log("path_to_request: " + path);

    String responseBody = await ApiClient.get( token, "/service/category/" + serviceCategoryID.toString()).catchError( (errorMessage){
      // TODO: parse error message
      _servicesStateController.sink.add(ServicesStateError(errorMessage));
      return;
    });

    List<dynamic> rawServices = json.decode(responseBody)["services"];
    List<Service> services = List();

    for(int i = 0; i < rawServices.length; i++){
      services.add(Service.fromJson(rawServices[i]));
    }

    _servicesStateController.sink.add(ServicesStateReady(services));
  }

  @override
  void dispose() {
    _servicesStateController.close();
}
}