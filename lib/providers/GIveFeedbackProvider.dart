import 'package:flutter/material.dart';
import 'package:style_buddy/models/GiveFeedbackModel.dart';
import 'package:style_buddy/services/GiveFeedbackServices.dart';

class GiveFeedbackProvider with ChangeNotifier {
  GiveFeedbackModel post = GiveFeedbackModel();

  getPostGiveFeedbackData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await GiveFeedbackServices.giveFeedbackService(url, body))!;
  }
}
