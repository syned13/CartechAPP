class User {
  int userID;
  String name;
  String lastName;
  String email;
  String phoneNumber;
  String password;

  User({this.name, this.lastName, this.email, this.phoneNumber, this.password});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    userID = json["user_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['password'] = this.password;

    return data;
  }
}