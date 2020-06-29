import 'package:cartech_app/src/blocs/bloc.dart';
import 'package:cartech_app/src/models/service_order.dart';
import 'package:cartech_app/src/resources/api_client.dart';
import 'package:cartech_app/src/resources/utils.dart';
import 'package:cartech_app/src/states/orders/order_detail_state.dart';
import 'package:rxdart/rxdart.dart';

const String canceledStatus = "canceled";
const String finishedStatus = "finished";

class OrderDetailBloc extends Bloc{
  ServiceOrder order;

  BehaviorSubject<OrderDetailState> _controller = new BehaviorSubject();
  Stream<OrderDetailState> get orderDetailStream => _controller.stream.asBroadcastStream();

  void init(){
    _controller.sink.add(OrderDetailStateInitial());
  }

  void cancellOrder() async{
    _controller.sink.add(OrderDetailStateLoading());
    Map<String, dynamic> patchRequest = Map();
    patchRequest["op"] = "replace";
    patchRequest['path'] = "status";
    patchRequest['value'] = canceledStatus;

    List<Map<String, dynamic>> patchRequests = List();
    patchRequests.add(patchRequest);

    String token = await Utils.getToken();
    String response;

    try{
    response = await ApiClient.patch(token, "/order/${order.serviceOrderId}", patchRequests);
    }catch(Exception){
      // TODO: parse the corresponding error
      _controller.sink.add(OrderDetailStateError(Exception.toString()));
    }

    _controller.sink.add(OrderDetailsStateCancelledDone());
  }

  void setOrderReady() async{
    _controller.sink.add(OrderDetailStateMarkReadyLoading());
    Map<String, dynamic> patchRequest = Map();
    patchRequest["op"] = "replace";
    patchRequest['path'] = "status";
    patchRequest['value'] = finishedStatus;

    List<Map<String, dynamic>> patchRequests = List();
    patchRequests.add(patchRequest);

    String token = await Utils.getToken();
    String response;

    try{
      response = await ApiClient.patch(token, "/order/${order.serviceOrderId}", patchRequests);
    }catch(Exception){
      // TODO: parse the corresponding error
      _controller.sink.add(OrderDetailStateError(Exception.toString()));
    }

    _controller.sink.add(OrderDetailStateMarkReadyDone());
  }

  @override
  void dispose() {
  }

  OrderDetailBloc(this.order);
}