class OrderDetailState {}

class OrderDetailStateInitial extends OrderDetailState{}

class OrderDetailStateLoading extends OrderDetailState {}

class OrderDetailStateError extends OrderDetailState {
  String errorMessage;

  OrderDetailStateError(this.errorMessage);
}

class OrderDetailStateMarkReadyLoading extends OrderDetailState {}

class OrderDetailStateMarkReadyDone extends OrderDetailState {}

class OrderDetailsStateCancelledDone extends OrderDetailState {}
