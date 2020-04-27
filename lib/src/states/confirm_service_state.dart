import 'package:cartech_app/src/models/service_request.dart';

class ConfirmServiceState {}

class ConfirmServiceStateInitial extends ConfirmServiceState{
  ServiceRequest serviceRequest;

  ConfirmServiceStateInitial(this.serviceRequest);
}

class ConfirmServiceStateLoading extends ConfirmServiceState {}

class ConfirmServiceStateError extends ConfirmServiceState {
  String errorMessage;

  ConfirmServiceStateError(this.errorMessage);
}

class ConfirmServiceStateDone extends ConfirmServiceState {}