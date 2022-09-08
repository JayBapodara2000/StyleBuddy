import 'package:flutter/material.dart';
import 'package:style_buddy/models/GetSBProfileDataModel.dart';
import 'package:style_buddy/services/GetSBProfileDataServices.dart';

class GetSBProfileDataProvider with ChangeNotifier {
  GetSBProfileDataModel post = GetSBProfileDataModel();

  getPostSBprofiledata(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post =
        (await GetSBProfileDataServices.getSBProfileDataService(url, body))!;
  }
}
