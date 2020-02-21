class SignUpState {
}

class SignUpStateLoading extends SignUpState{

}

class SignUpStateError extends SignUpState{
  String errorMessage;

  SignUpStateError(this.errorMessage);

}

class SignUpStateDone extends SignUpState{

}