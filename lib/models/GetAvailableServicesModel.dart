class GetAvailableServicesModel {
  int? statusCode;
  List<Body1>? body;
  String? status;

  GetAvailableServicesModel({this.statusCode, this.body, this.status});

  GetAvailableServicesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['body'] != null) {
      body = <Body1>[];
      json['body'].forEach((v) {
        body!.add(new Body1.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.body != null) {
      data['body'] = this.body!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Body1 {
  int? servicedtlid;
  String? servicename;
  int? approxmm;
  int? iconid;
  bool isSelected = false;

  Body1({this.servicedtlid, this.servicename, this.approxmm, this.iconid});

  Body1.fromJson(Map<String, dynamic> json) {
    servicedtlid = json['servicedtlid'];
    servicename = json['servicename'];
    approxmm = json['approxmm'];
    iconid = json['iconid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['servicedtlid'] = this.servicedtlid;
    data['servicename'] = this.servicename;
    data['approxmm'] = this.approxmm;
    data['iconid'] = this.iconid;
    return data;
  }
}
