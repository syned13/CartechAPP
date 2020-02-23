class LoginState{}

class LoginStateLoading extends LoginState{}

class LoginStateError extends LoginState{
  String errorMessage;

  LoginStateError(this.errorMessage);

}

class LoginStateReady extends LoginState{}