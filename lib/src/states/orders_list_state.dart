import 'package:cartech_app/src/models/service_order.dart';

class OrdersListState {}

class OrdersListStateLoading extends OrdersListState{}

class OrdersListStateError extends OrdersListState{
  String errorMessage;

  OrdersListStateError(this.errorMessage);
}

class OrderListStateDone extends OrdersListState{
  List<ServiceOrder> orders;

  OrderListStateDone(this.orders);
}