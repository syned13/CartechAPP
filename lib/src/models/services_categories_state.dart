import 'package:cartech_app/src/models/service_category.dart';
import 'package:cartech_app/src/models/user.dart';

import 'service_category.dart';

class ServicesCategoriesState{}

class ServicesCategoriesStateLoading extends ServicesCategoriesState{}

class ServicesCategoriesStateError extends ServicesCategoriesState{
  String errorMessage;

  ServicesCategoriesStateError(this.errorMessage);
}

class ServicesCategoriesStateReady extends ServicesCategoriesState{
  User user;
  List<ServiceCategory> serviceCategories;
}