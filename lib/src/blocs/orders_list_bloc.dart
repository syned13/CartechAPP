
import 'dart:convert';

import 'package:cartech_app/src/models/service_order.dart';
import 'package:cartech_app/src/resources/api_client.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:cartech_app/src/states/orders_list_state.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class OrdersListBloc extends Bloc {

  BehaviorSubject<OrdersListState> _currentOrdersController = BehaviorSubject();
  BehaviorSubject<OrdersListState> _pastOrdersController = BehaviorSubject();

  Stream<OrdersListState> get currentOrdersStream => _currentOrdersController.stream.asBroadcastStream();
  Stream<OrdersListState> get pastOrdersStream => _currentOrdersController.stream.asBroadcastStream();

  void initCurrentOrders() async {
    _currentOrdersController.sink.add(OrdersListStateLoading());

    try{
      String token = await Utils.getToken();
      String response = await ApiClient.get(token, "/orders/current");
      List<Map<String, dynamic>> ordersMaps = json.decode(response);

      List<ServiceOrder> orders = _parseServiceOrders(ordersMaps);

      _currentOrdersController.sink.add(OrderListStateDone(orders));
    }
    catch(Exception){
     String errorMessage = Exception.toString();
     _currentOrdersController.sink.add(OrdersListStateError(errorMessage));
    }
  }

  void initPastOrders(){
    _pastOrdersController.sink.add(OrdersListStateLoading());
  }

  List<ServiceOrder> _parseServiceOrders(List<Map<String,dynamic>> ordersMaps){
    List<ServiceOrder> orders = List();

    for(int i = 0; i < ordersMaps.length; i++){
      orders.add(ServiceOrder.fromJson(ordersMaps[i]));
    }

    return orders;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}