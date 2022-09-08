class MonthWiseAppointmentModel {
  int? statusCode;
  List<Body>? body;
  String? status;

  MonthWiseAppointmentModel({this.statusCode, this.body, this.status});

  MonthWiseAppointmentModel.fromJson(Map<String, dynamic> json) {
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
  String? styleBuddyName;
  int? totalTime;
  String? services;
  String? bookingDate;
  String? avatar;
  int? icon;

  Body(
      {this.styleBuddyName,
      this.totalTime,
      this.services,
      this.bookingDate,
      this.avatar,
      this.icon});

  Body.fromJson(Map<String, dynamic> json) {
    styleBuddyName = json['StyleBuddyName'];
    totalTime = json['TotalTime'];
    services = json['Services'];
    bookingDate = json['BookingDate'];
    avatar = json['Avatar'];
    icon = json['Icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StyleBuddyName'] = this.styleBuddyName;
    data['TotalTime'] = this.totalTime;
    data['Services'] = this.services;
    data['BookingDate'] = this.bookingDate;
    data['Avatar'] = this.avatar;
    data['Icon'] = this.icon;
    return data;
  }
}
