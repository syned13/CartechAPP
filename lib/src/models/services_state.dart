import 'package:cartech_app/src/models/user.dart';

class ServicesState{}

class ServicesStateLoading extends ServicesState{}

class ServicesStateError extends ServicesState{}

class ServicesStateReady extends ServicesState{
  User user;
}