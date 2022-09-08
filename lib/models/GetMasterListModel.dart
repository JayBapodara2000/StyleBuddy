class GetMasterListModel {
  int? statusCode;
  List<GetMasterBody>? body;
  String? status;

  GetMasterListModel({this.statusCode, this.body, this.status});

  GetMasterListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['body'] != null) {
      body = <GetMasterBody>[];
      json['body'].forEach((v) {
        body!.add(new GetMasterBody.fromJson(v));
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

class GetMasterBody {
  int? stylemasterid;
  String? username;

  GetMasterBody({this.stylemasterid, this.username});

  GetMasterBody.fromJson(Map<String, dynamic> json) {
    stylemasterid = json['stylemasterid'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stylemasterid'] = this.stylemasterid;
    data['username'] = this.username;
    return data;
  }
}
