class ServiceOrder {
  int serviceOrderId;
  int serviceId;
  String serviceName;
  int userId;
  int mechanicId;
  String createdAt;
  Null startedAt;
  String status;
  Null finishedAt;
  Null cancelledAt;
  double lat;
  double lng;


  ServiceOrder(
      {this.serviceOrderId,
        this.serviceId,
        this.serviceName,
        this.userId,
        this.mechanicId,
        this.createdAt,
        this.startedAt,
        this.status,
        this.finishedAt,
        this.cancelledAt,
        this.lat,
        this.lng});

  ServiceOrder.fromJson(Map<String, dynamic> json) {
    serviceOrderId = json['service_order_id'];
    serviceId = json['service_id'];
    serviceName = json["service_name"];
    userId = json['user_id'];
    mechanicId = json['mechanic_id'];
    createdAt = json['created_at'];
    startedAt = json['started_at'];
    status = json['status'];
    finishedAt = json['finished_at'];
    cancelledAt = json['cancelled_at'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_order_id'] = this.serviceOrderId;
    data['service_id'] = this.serviceId;
    data["service_name"] = this.serviceName;
    data['user_id'] = this.userId;
    data['mechanic_id'] = this.mechanicId;
    data['created_at'] = this.createdAt;
    data['started_at'] = this.startedAt;
    data['status'] = this.status;
    data['finished_at'] = this.finishedAt;
    data['cancelled_at'] = this.cancelledAt;
    data['lat'] = this.lat;
    data['lng'] = this.lng;

    return data;
  }
}