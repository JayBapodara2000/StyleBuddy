class LoginModel {
  int? statusCode;
  List<Body>? body;
  String? status;

  LoginModel({this.statusCode, this.body, this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? avatar;
  int? loginstatus;
  String? token;
  int? userid;
  int? custid;
  String? username;
  String? profileimgpath;

  Body(
      {this.avatar,
      this.loginstatus,
      this.token,
      this.userid,
      this.custid,
      this.username,
      this.profileimgpath});

  Body.fromJson(Map<String, dynamic> json) {
    avatar = json['Avatar'];
    loginstatus = json['Loginstatus'];
    token = json['token'];
    userid = json['userid'];
    custid = json['custid'];
    username = json['username'];
    profileimgpath = json['profileimgpath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Avatar'] = this.avatar;
    data['Loginstatus'] = this.loginstatus;
    data['token'] = this.token;
    data['userid'] = this.userid;
    data['custid'] = this.custid;
    data['username'] = this.username;
    data['profileimgpath'] = this.profileimgpath;
    return data;
  }
}
