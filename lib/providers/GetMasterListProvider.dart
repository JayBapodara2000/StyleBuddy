import 'package:flutter/material.dart';
import 'package:style_buddy/models/GetMasterListModel.dart';
import 'package:style_buddy/services/GetMasterListServices.dart';

class GetMasterListProvider with ChangeNotifier {
  GetMasterListModel post = GetMasterListModel();

  getPostMasterListData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    // notifyListeners();
    return post =
        (await GetMasterListServices.getMasterListService(url, body))!;
  }
}
