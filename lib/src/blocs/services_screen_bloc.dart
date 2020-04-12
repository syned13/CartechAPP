import 'package:cartech_app/src/models/service_category.dart';
import 'package:cartech_app/src/models/services_state.dart';
import 'package:cartech_app/src/resources/api_client.dart';
import 'package:cartech_app/src/resources/db_provider.dart';
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

    DateTime updateDate = await DBProvider.db.getServiceUpdateDate(serviceCategoryID);

    if( updateDate != null && updateDate.difference(DateTime.now().toUtc()).inHours < 24) {
      developer.log("RETRIEVING SERVICES FROM LOCAL DATABASE");

      List<Service> services = await DBProvider.db.getServicesFromCategory(serviceCategoryID);
      _servicesStateController.sink.add(ServicesStateReady(services));
      return;
    }

    developer.log("RETRIEVING SERVICES FROM API");
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

    //TODO: catch when result is 0
    int result = await DBProvider.db.deleteAllServices();
    for(int i = 0; i < services.length; i++){
      int result = await DBProvider.db.createService(services[i]);
      if(result == 0){
        developer.log("ERROR INSERTING SERVICES");
        break;
      }
    }

    _servicesStateController.sink.add(ServicesStateReady(services));
  }

  @override
  void dispose() {
    _servicesStateController.close();
}
}