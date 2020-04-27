import 'package:cartech_app/src/models/service_category.dart';
import 'package:cartech_app/src/models/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceRequest{
  Service service;
  LatLng serviceLocation;
  User user;

  Map<String, dynamic> toJSON(){
    Map<String, dynamic> returnMap = Map();
    returnMap["service_id"] = service.serviceId;
    returnMap["user_id"] = user.userID;
    returnMap["lat"] = serviceLocation.latitude;
    returnMap["lng"] = serviceLocation.longitude;

    return returnMap;
  }
}

