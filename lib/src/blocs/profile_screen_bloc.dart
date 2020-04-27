
import 'package:cartech_app/src/models/user.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:cartech_app/src/states/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class ProfileScreenBloc extends Bloc{

  BehaviorSubject<ProfileState> _controller = BehaviorSubject();

  Stream<ProfileState> get userStream => _controller.stream.asBroadcastStream();

  void getUser() async {
    _controller.sink.add(ProfileStateLoading());
    User user = await Utils.getLoggedUserInfo().catchError( (error){
      _controller.sink.add(ProfileStateError(error.toString()));
      return;
    });

    _controller.sink.add(ProfileStateDone(user));
  }

  @override
  void dispose() {
    _controller.close();
  }
}