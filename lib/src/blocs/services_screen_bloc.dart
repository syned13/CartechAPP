
import 'dart:async';
import 'dart:developer';

import 'package:cartech_app/src/models/services_state.dart';
import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class MainScreeBloc extends Bloc{

  BehaviorSubject<ServicesState> _servicesStateController = BehaviorSubject();
  User _user = User();

  Stream<ServicesState> get servicesStateStream => _servicesStateController.stream.asBroadcastStream();

  void init() async {
    _servicesStateController.sink.add(ServicesStateLoading());

    this._user = await Utils.getLoggedUserInfo();

    ServicesStateReady servicesStateReady = ServicesStateReady();
    servicesStateReady.user = this._user;

    _servicesStateController.sink.add(servicesStateReady);


  }

  @override
  void dispose() {
    _servicesStateController.close();
  }


}