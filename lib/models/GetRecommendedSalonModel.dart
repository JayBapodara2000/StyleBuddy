class GetRecommendedSalonModel {
  int? statusCode;
  List<BodyRS>? body;
  String? status;

  GetRecommendedSalonModel({this.statusCode, this.body, this.status});

  GetRecommendedSalonModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['body'] != null) {
      body = <BodyRS>[];
      json['body'].forEach((v) {
        body!.add(new BodyRS.fromJson(v));
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

class BodyRS {
  int? entityID;
  String? entityName;
  int? ratings;
  double? distance;

  BodyRS({this.entityID, this.entityName, this.ratings, this.distance});

  BodyRS.fromJson(Map<String, dynamic> json) {
    entityID = json['EntityID'];
    entityName = json['EntityName'];
    ratings = json['Ratings'];
    distance = json['Distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EntityID'] = this.entityID;
    data['EntityName'] = this.entityName;
    data['Ratings'] = this.ratings;
    data['Distance'] = this.distance;
    return data;
  }
}