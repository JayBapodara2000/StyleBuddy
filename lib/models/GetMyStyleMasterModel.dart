class GetMyStyleMasterModel {
  int? statusCode;
  List<Body>? body;
  String? status;

  GetMyStyleMasterModel({this.statusCode, this.body, this.status});

  GetMyStyleMasterModel.fromJson(Map<String, dynamic> json) {
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
  int? stylemasterid;
  String? name;
  String? profileimgpath;
  int? flag;
  String? avatar;
  double? rating;
  String? entname;

  Body(
      {this.stylemasterid,
      this.name,
      this.profileimgpath,
      this.flag,
      this.avatar,
      this.rating,
      this.entname});

  Body.fromJson(Map<String, dynamic> json) {
    stylemasterid = json['stylemasterid'];
    name = json['name'];
    profileimgpath = json['profileimgpath'];
    flag = json['flag'];
    avatar = json['avatar'];
    rating = json['rating'];
    entname = json['entname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stylemasterid'] = this.stylemasterid;
    data['name'] = this.name;
    data['profileimgpath'] = this.profileimgpath;
    data['flag'] = this.flag;
    data['avatar'] = this.avatar;
    data['rating'] = this.rating;
    data['entname'] = this.entname;
    return data;
  }
}
