import 'package:cartech_app/src/models/user.dart';

import 'services.dart';

class ServicesState{}

class ServicesStateLoading extends ServicesState{}

class ServicesStateError extends ServicesState{
  String errorMessage;

  ServicesStateError(this.errorMessage);
}

class ServicesStateReady extends ServicesState{
  User user;
  Services services;
}