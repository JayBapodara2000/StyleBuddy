import 'package:flutter/material.dart';
import 'package:style_buddy/models/EmailAndMobileValidationModel.dart';
import 'package:style_buddy/services/EmailAndMobileValidationServices.dart';

class EmailAndMobileValidationProvider with ChangeNotifier {
  EmailAndMobileValidationModel post = EmailAndMobileValidationModel();

  getPostEmailAndMobileValidationData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post =
        (await EmailAndMobileValidationServices.emailAndMobileValidationService(
            url, body))!;
  }
}
