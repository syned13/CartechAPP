
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:cartech_app/src/models/service_category.dart';
import 'package:cartech_app/src/models/services_categories_state.dart';
import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/api_client.dart';
import 'package:cartech_app/src/resources/db_provider.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

import 'bloc.dart';
import 'package:path/path.dart';

class ServicesCategoriesScreenBloc extends Bloc{

  BehaviorSubject<ServicesCategoriesState> _servicesCategoriesStateController = BehaviorSubject();
  User _user = User();

  Stream<ServicesCategoriesState> get servicesStateStream => _servicesCategoriesStateController.stream.asBroadcastStream();

  void init() async {
    _servicesCategoriesStateController.sink.add(ServicesCategoriesStateLoading());
    this._user = await Utils.getLoggedUserInfo();

    DateTime updatedDate = await DBProvider.db.getCategoryUpdateDate();

    if(updatedDate != null && updatedDate.difference(DateTime.now().toUtc()).inHours < 24){
      developer.log("RETRIEVING FROM LOCAL DATABASE");

      List<ServiceCategory> categories = await DBProvider.db.getCategories();

      ServicesCategoriesStateReady servicesStateReady = ServicesCategoriesStateReady();
      servicesStateReady.user = this._user;
      servicesStateReady.serviceCategories = categories;

      _servicesCategoriesStateController.sink.add(servicesStateReady);
      return;
    }

    developer.log("RETRIEVING FROM API");
    String token = await Utils.getToken();

    String response = await ApiClient.get(token, "/service/category").catchError( (error) {
      String errorMessage = error.toString();

      if(errorMessage == "timeout"){
        errorMessage = "Ha ocurrido un error de conexión";
      }
      else if(errorMessage == "internal server error"){
        errorMessage = "Ha ocurrido un error";
      }

      _servicesCategoriesStateController.sink.add(ServicesCategoriesStateError(error.toString()));
      return;
    });

    developer.log(response.toString());
    Map<String, dynamic> responseMap = json.decode(response);
    List<ServiceCategory> serviceCategories = ServiceCategory.listFromJSON(responseMap);

    int result = await DBProvider.db.deleteAllServiceCategories();
    developer.log("DELETED ROWS: " + result.toString());
    if(result == 0){
      developer.log("ERROR BORRANDO ANTIGUOS");
    }

    for(int i = 0; i < serviceCategories.length; i++){
      int result = await DBProvider.db.createServiceCategory(serviceCategories[i]);
      if(result == 0) {
        developer.log("ERROR INSERTANDO NUEVA CATEGORIA");
        break;
      }
    }

    ServicesCategoriesStateReady servicesStateReady = ServicesCategoriesStateReady();
    servicesStateReady.user = this._user;
    servicesStateReady.serviceCategories = serviceCategories;

    _servicesCategoriesStateController.sink.add(servicesStateReady);
  }

  @override
  void dispose() {
    _servicesCategoriesStateController.close();
  }
}