import 'package:flutter/material.dart';

import '../models/BookAppointmentModel.dart';
import '../services/BookAppointmentServices.dart';


class BookAppointmentProvider with ChangeNotifier {
  BookAppointmentModel post = BookAppointmentModel();

  getPostBookAppointmentdata(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await BookAppointmentServices.bookAppointment(url, body))!;
  }
}

