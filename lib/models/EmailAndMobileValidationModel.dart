class EmailAndMobileValidationModel {
  int? statusCode;
  Body? body;
  String? status;

  EmailAndMobileValidationModel({this.statusCode, this.body, this.status});

  EmailAndMobileValidationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Body {
  bool? isavilable;

  Body({this.isavilable});

  Body.fromJson(Map<String, dynamic> json) {
    isavilable = json['isavilable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isavilable'] = this.isavilable;
    return data;
  }
}
