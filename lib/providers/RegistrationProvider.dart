import 'package:flutter/material.dart';
import 'package:style_buddy/models/RegistrationModel.dart';
import 'package:style_buddy/services/RegistrationServices.dart';

class RegisterProvider with ChangeNotifier {
  RegistrationModel post = RegistrationModel();

  getPostRegisterData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await RegistrationServices.userRegisterService(url, body))!;
  }
}
