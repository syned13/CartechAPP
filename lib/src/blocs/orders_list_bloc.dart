
import 'dart:convert';

import 'package:cartech_app/src/models/service_category.dart';
import 'package:cartech_app/src/models/service_order.dart';
import 'package:cartech_app/src/resources/api_client.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:cartech_app/src/states/orders_list_state.dart';
import 'package:cartech_app/src/ui/orders_list_screen.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';
import 'dart:developer' as developer;

class OrdersListBloc extends Bloc {

  BehaviorSubject<OrdersListState> _currentOrdersController = BehaviorSubject();
  BehaviorSubject<OrdersListState> _pastOrdersController = BehaviorSubject();

  Stream<OrdersListState> get currentOrdersStream => _currentOrdersController.stream.asBroadcastStream();
  Stream<OrdersListState> get pastOrdersStream => _currentOrdersController.stream.asBroadcastStream();

  void initOrders(OrderListType orderListType) async {
    _currentOrdersController.sink.add(OrdersListStateLoading());

    String path = "current";
    if(orderListType == OrderListType.Past){
      path = "past";
    }

    try{
      String token = await Utils.getToken();
      String response = await ApiClient.get(token, "/order/$path");
      List<dynamic> ordersMaps = json.decode(response);

      List<ServiceOrder> orders = ordersMaps.map( (order) => ServiceOrder.fromJson(order)).toList();
//      List<ServiceOrder> orders = List();
//      orders.add(_getDummyOrder());

      _currentOrdersController.sink.add(OrderListStateDone(orders));
    }
    catch(Exception){
     String errorMessage = Exception.toString();
     _currentOrdersController.sink.add(OrdersListStateError(errorMessage));
    }
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
    _currentOrdersController.close();
    _pastOrdersController.close();
  }

  ServiceOrder _getDummyOrder(){
    ServiceOrder order = ServiceOrder();
    order.serviceName = "Cambio de frenos";
    order.serviceId = 3;
    order.userId = 3;
    order.createdAt = DateTime.now().toString();
    order.status = "pending";

    return order;
  }
}