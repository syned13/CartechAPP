import 'dart:async';
import 'dart:developer' as developer;

import 'package:cartech_app/src/blocs/bloc.dart';
import 'package:cartech_app/src/models/service_request.dart';
import 'package:cartech_app/src/resources/api_client.dart';
import 'package:cartech_app/src/states/confirm_service_state.dart';
import 'package:rxdart/rxdart.dart';

class ConfirmServiceScreenBloc extends Bloc {
  ServiceRequest serviceRequest;

  ConfirmServiceScreenBloc(this.serviceRequest);

  BehaviorSubject<ConfirmServiceState> _controller = new BehaviorSubject();

  Stream<ConfirmServiceState> get confirmServiceStream =>
      _controller.stream.asBroadcastStream();

  void init() {
    _controller.sink.add(ConfirmServiceStateInitial(this.serviceRequest));
  }

  void confirmServiceRequest() async {
    _controller.sink.add(ConfirmServiceStateLoading());
    bool success = true;
    String response = await ApiClient.post(serviceRequest.toJSON(), "/order")
        .catchError((error) {
      String errorMessage = error.toString();
      developer.log("error_message_confirm_service_order: " + errorMessage);
      if (errorMessage == "internal server error") {
        errorMessage = "Ha ocurrido un error";
      } else if (errorMessage ==
          "user is not allowed to have more than one service") {
        errorMessage = "Ya tienes una orden en curso";
      } else {
        errorMessage = "Ha ocurrido un error";
      }

      developer.log("HERE");
      _controller.sink.add(ConfirmServiceStateError(errorMessage));
      success = false;
    });

    if (success) {
      _controller.sink.add(ConfirmServiceStateDone());
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
