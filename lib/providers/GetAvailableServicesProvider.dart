import 'package:flutter/material.dart';
import 'package:style_buddy/services/GetAvailableServices.dart';

import '../models/GetAvailableServicesModel.dart';
class GetAvailableServicesProvider with ChangeNotifier {
  GetAvailableServicesModel post = GetAvailableServicesModel();

  getPostAvailableServicesData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post =
    (await GetAvailableServices.getAvailableService(
        url, body))!;
  }
}

