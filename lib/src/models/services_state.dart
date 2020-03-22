import 'package:cartech_app/src/models/service_category.dart';

class ServicesState{}

class ServicesStateLoading extends ServicesState{}

class ServicesStateError extends ServicesState{
  String errorMessage;

  ServicesStateError(this.errorMessage);
}

class ServicesStateReady extends ServicesState{
  List<Service> services;

  ServicesStateReady(this.services);

}