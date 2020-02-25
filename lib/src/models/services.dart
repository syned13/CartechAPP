class Services {
  List<Service> services;

  Services({this.services});

  Services.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = new List<Service>();
      json['services'].forEach((v) {
        services.add(new Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  String serviceCategory;
  int serviceCategoryId;

  Service({this.serviceCategory, this.serviceCategoryId});

  Service.fromJson(Map<String, dynamic> json) {
    serviceCategory = json['service_category'];
    serviceCategoryId = json['service_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_category'] = this.serviceCategory;
    data['service_category_id'] = this.serviceCategoryId;
    return data;
  }
}
