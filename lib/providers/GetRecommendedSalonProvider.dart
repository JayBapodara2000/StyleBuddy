import 'package:flutter/material.dart';
import 'package:style_buddy/models/GetRecommendedSalonModel.dart';
import 'package:style_buddy/services/GetRecommendedSalonServices.dart';

class GetRecommendedSalonProvider with ChangeNotifier {
  GetRecommendedSalonModel post = GetRecommendedSalonModel();

  getPostGetRecommendedSalonData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post =
    (await GetRecommendedSalonServices.getRecommendedSalonService(url, body))!;
  }
}