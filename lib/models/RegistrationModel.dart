class RegistrationModel {
  int? statusCode;
  List<dynamic>? body;
  String? status;

  RegistrationModel({this.statusCode, this.body, this.status});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    body = json['body'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['body'] = this.body;
    data['status'] = this.status;

    return data;
  }
}
