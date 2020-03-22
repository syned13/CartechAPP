import 'package:geolocator/geolocator.dart';

class SelectServiceLocationState {}

class SelectServiceLocationStateLoading extends SelectServiceLocationState{}

class SelectServiceLocationStateError extends SelectServiceLocationState{
  String errorMessage;

  SelectServiceLocationStateError(this.errorMessage);
}

class SelectServiceLocationStateReady extends SelectServiceLocationState{
  Position position;
}

