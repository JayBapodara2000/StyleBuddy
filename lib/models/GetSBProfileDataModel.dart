class GetSBProfileDataModel {
  int? statusCode;
  List<BodyOfGetSBProfileData>? body;
  String? status;

  GetSBProfileDataModel({this.statusCode, this.body, this.status});

  GetSBProfileDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['body'] != null) {
      body = <BodyOfGetSBProfileData>[];
      json['body'].forEach((v) {
        body!.add(new BodyOfGetSBProfileData.fromJson(v));
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

class BodyOfGetSBProfileData {
  int? custID;
  String? emailID;
  String? username;
  String? mobile;
  String? styleMasterName;
  String? salonname;
  String? address;
  String? latitiude;
  String? longitude;

  BodyOfGetSBProfileData(
      {this.custID,
      this.emailID,
      this.username,
      this.mobile,
      this.styleMasterName,
      this.salonname,
      this.address,
      this.latitiude,
      this.longitude});

  BodyOfGetSBProfileData.fromJson(Map<String, dynamic> json) {
    custID = json['CustID'];
    emailID = json['EmailID'];
    username = json['Username'];
    mobile = json['Mobile'];
    styleMasterName = json['StyleMasterName'];
    salonname = json['Salonname'];
    address = json['Address'];
    latitiude = json['Latitiude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustID'] = this.custID;
    data['EmailID'] = this.emailID;
    data['Username'] = this.username;
    data['Mobile'] = this.mobile;
    data['StyleMasterName'] = this.styleMasterName;
    data['Salonname'] = this.salonname;
    data['Address'] = this.address;
    data['Latitiude'] = this.latitiude;
    data['Longitude'] = this.longitude;
    return data;
  }
}
