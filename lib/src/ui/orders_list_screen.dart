import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:cartech_app/src/blocs/orders_list_bloc.dart';
import 'package:cartech_app/src/models/service_order.dart';
import 'package:cartech_app/src/states/orders_list_state.dart';
import 'package:cartech_app/src/ui/order_detail_screen.dart';
import 'package:cartech_app/src/ui/theme_resources.dart';


enum OrderListType { Current, Past }

class OrdersList extends StatelessWidget {
  final OrdersListBloc _bloc = OrdersListBloc();
  final OrderListType orderListType;

  OrdersList(this.orderListType);

  String _getDateFromDate(String sDate) {
    DateTime dateTime = DateTime.parse(sDate);
    return "${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()}";
  }

  String _getHourFromDate(String sDate) {
    DateTime dateTime = DateTime.parse(sDate);
    return "${dateTime.hour}:${dateTime.minute}";
  }

  String _parseStatus(String status) {
    if (status == "pending") {
      return "Pendiente";
    } else if (status == "in_progress") {
      return "En progreso";
    }

    return "";
  }

  Widget _orderList(List<ServiceOrder> orders, BuildContext context) {
    List<Widget> cards = List();

    for (int i = 0; i < orders.length; i++) {
      cards.add(InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderDetailScreen(orders[i]))).then( (value){
                    _bloc.initOrders(this.orderListType);
          });
        },
        child: Card(
          color: orders[i].status == "pending"? Resources.MainColor: Resources.SecondaryColor,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _getDateFromDate(orders[i].createdAt),
                  style: Resources.WhiteTextStyle,
                ),
                Text(_getHourFromDate(orders[i].createdAt),
                    style: Resources.WhiteTextStyle),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Estado de la orden: " + _parseStatus(orders[i].status),
                  style: Resources.WhiteTextStyle,
                ),
                Text(orders[i].serviceName, style: Resources.WhiteTextStyle),
                Text("RD\$ 600", style: Resources.WhiteTextStyle),
              ],
            ),
          ),
        ),
      ));
    }

    return ListView(
      children: cards,
    );
  }

  @override
  Widget build(BuildContext context) {
    _bloc.initOrders(orderListType);

    return Container(
      padding: EdgeInsets.all(15),
      child: StreamBuilder<OrdersListState>(
          stream: this.orderListType == OrderListType.Past
              ? _bloc.currentOrdersStream
              : _bloc.pastOrdersStream,
          builder: (context, snapshot) {
            if (snapshot.data is OrdersListStateLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data is OrdersListStateError) {
              OrdersListStateError errorState = snapshot.data;
              String errorMessage = errorState.errorMessage;

              return Center(
                  child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red[300]),
              ));
            }

            if (snapshot.data is OrderListStateDone) {
              OrderListStateDone stateDone = snapshot.data;
              List<ServiceOrder> orders = stateDone.orders;

              if (orders.length == 0) {
                return Center(
                  child: Text("Todavia no tienes ordenes"),
                );
              }
              return _orderList(orders, context);
            }

            return Center(child: Text("You have no orders yet"));
          }),
    );
  }
}

class OrdersListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Órdenes"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Actuales",
              ),
              Tab(
                text: "Pasadas",
              ),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          OrdersList(OrderListType.Current),
          OrdersList(OrderListType.Past),
        ]),
      ),
    );
  }
}
