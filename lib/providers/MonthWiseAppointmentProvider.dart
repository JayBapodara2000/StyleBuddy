import 'package:flutter/material.dart';
import 'package:style_buddy/models/MonthWiseAppointmentModel.dart';
import 'package:style_buddy/services/MonthWiseAppointmentServices.dart';

class MonthWiseAppointmentProvider with ChangeNotifier {
  MonthWiseAppointmentModel post = MonthWiseAppointmentModel();

  getPostMonthWiseAppointment(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    //notifyListeners();
    return post = (await MonthWiseAppointmentServices.getMonthWiseAppointment(
        url, body))!;
  }
}
