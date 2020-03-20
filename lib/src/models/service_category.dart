class ServiceCategory {
  String serviceCategory;
  int serviceCategoryId;
  List<Services> services;

  ServiceCategory(
      {this.serviceCategory, this.serviceCategoryId, this.services});

  ServiceCategory.fromJson(Map<String, dynamic> json) {
    serviceCategory = json['service_category'];
    serviceCategoryId = json['service_category_id'];
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
  }

  static List<ServiceCategory> listFromJSON(Map<String, dynamic> json){
    if(json["service_categories"] == null){
      return null;
    }

    List<ServiceCategory> categories = List<ServiceCategory>();
    json["service_categories"].forEach((v) {
      categories.add(ServiceCategory.fromJson(v));
    });

    return categories;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_category'] = this.serviceCategory;
    data['service_category_id'] = this.serviceCategoryId;
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int serviceId;
  String serviceName;
  int serviceCategoryId;

  Services({this.serviceId, this.serviceName, this.serviceCategoryId});

  Services.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    serviceCategoryId = json['service_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    data['service_category_id'] = this.serviceCategoryId;
    return data;
  }
}