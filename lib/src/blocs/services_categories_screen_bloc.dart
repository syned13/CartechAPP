
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:cartech_app/src/models/service_category.dart';
import 'package:cartech_app/src/models/services_categories_state.dart';
import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/api_client.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class ServicesCategoriesScreenBloc extends Bloc{

  BehaviorSubject<ServicesCategoriesState> _servicesCategoriesStateController = BehaviorSubject();
  User _user = User();

  Stream<ServicesCategoriesState> get servicesStateStream => _servicesCategoriesStateController.stream.asBroadcastStream();

  void init() async {
    _servicesCategoriesStateController.sink.add(ServicesCategoriesStateLoading());

    this._user = await Utils.getLoggedUserInfo();

    String token = await Utils.getToken();

//    String response = "{\r\n    \"services\": [\r\n        {\r\n            \"service_category\": \"Frenos\",\r\n            \"service_category_id\": 1\r\n        },\r\n        {\r\n            \"service_category\": \"Afinaci\u00F3n de motor\",\r\n            \"service_category_id\": 2\r\n        },\r\n        {\r\n            \"service_category\": \"Cambio de aceite y lubricaci\u00F3n\",\r\n            \"service_category_id\": 3\r\n        },\r\n        {\r\n            \"service_category\": \"Mantenimiento de suspensi\u00F3n\",\r\n            \"service_category_id\": 4\r\n        },\r\n        {\r\n            \"service_category\": \"Revisi\u00F3n el\u00E9ctrica\",\r\n            \"service_category_id\": 5\r\n        }\r\n    ]\r\n}";
    String response = await ApiClient.get(token, "/service/category").catchError( (error) {
      //TODO: wrap error message
      _servicesCategoriesStateController.sink.add(ServicesCategoriesStateError(error.toString()));
      return;
    });

    developer.log(response.toString());
    Map<String, dynamic> responseMap = json.decode(response);
    List<ServiceCategory> serviceCategories = ServiceCategory.listFromJSON(responseMap);

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