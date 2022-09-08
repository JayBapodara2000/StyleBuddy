import 'package:flutter/material.dart';
import 'package:style_buddy/models/LoginModel.dart';
import 'package:style_buddy/services/LoginServices.dart';

class LoginProvider with ChangeNotifier {
  LoginModel post = LoginModel();

  getPostLoginData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post = (await LoginServices.userLoginService(url, body))!;
  }
}
