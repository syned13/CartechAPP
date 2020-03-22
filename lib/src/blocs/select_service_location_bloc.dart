import 'package:cartech_app/src/models/select_service_location_state.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class SelectServiceLocationBloc extends Bloc{

  BehaviorSubject<SelectServiceLocationState> _selectServiceStateController = BehaviorSubject();
  
  Stream<SelectServiceLocationState> get selectServiceStateStream => _selectServiceStateController.stream.asBroadcastStream();
  
  void getInitialLocation() async{
    _selectServiceStateController.sink.add(SelectServiceLocationStateLoading());
    Position currentLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best).catchError( (error){
      _selectServiceStateController.sink.add(SelectServiceLocationStateError(error.toString()));
      return;
    });

    SelectServiceLocationStateReady selectServiceLocationStateReady = SelectServiceLocationStateReady();
    selectServiceLocationStateReady.position = currentLocation;
    _selectServiceStateController.sink.add(selectServiceLocationStateReady);
  }
  
  @override
  void dispose() {
    _selectServiceStateController.close();
  }
}