import 'package:cartech_app/src/models/user.dart';

class ProfileState {}

class ProfileStateLoading extends ProfileState{}

class ProfileStateError extends ProfileState {
  String errorMessage;

  ProfileStateError(this.errorMessage);
}

class ProfileStateDone extends ProfileState {
  User user;

  ProfileStateDone(this.user);
}