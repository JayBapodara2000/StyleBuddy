import 'package:flutter/material.dart';
import 'package:style_buddy/models/GetMyStyleMasterModel.dart';
import 'package:style_buddy/services/GetMyStyleMasterServices.dart';

class GetMyStyleMasterProvider with ChangeNotifier {
  GetMyStyleMasterModel post = GetMyStyleMasterModel();

  getPostGetMyStyleMasterData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    //notifyListeners();
    return post =
        (await GetMyStyleMasterServices.getMyStyleMasterService(url, body))!;
  }
}
