class SearchSalonAutoModel {
  int? statusCode;
  List<Body>? body;
  String? status;

  SearchSalonAutoModel({this.statusCode, this.body, this.status});

  SearchSalonAutoModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['body'] != null) {
      body = <Body>[];
      json['body'].forEach((v) {
        body!.add(new Body.fromJson(v));
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

class Body {
  String? entityName;
  String? address;
  int? entityID;

  Body({this.entityName, this.address, this.entityID});

  Body.fromJson(Map<String, dynamic> json) {
    entityName = json['EntityName'];
    address = json['Address'];
    entityID = json['EntityID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EntityName'] = this.entityName;
    data['Address'] = this.address;
    data['EntityID'] = this.entityID;
    return data;
  }
}
