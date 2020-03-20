import 'package:cartech_app/src/models/service_category.dart';
import 'package:cartech_app/src/models/user.dart';

import 'service_category.dart';

class ServicesState{}

class ServicesStateLoading extends ServicesState{}

class ServicesStateError extends ServicesState{
  String errorMessage;

  ServicesStateError(this.errorMessage);
}

class ServicesStateReady extends ServicesState{
  User user;
  List<ServiceCategory> serviceCategories;
}