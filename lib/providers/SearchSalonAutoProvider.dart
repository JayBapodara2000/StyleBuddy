import 'package:flutter/material.dart';
import 'package:style_buddy/models/SearchSalonAutoModel.dart';
import 'package:style_buddy/services/SearchSalonAutoServices.dart';

class SearchSalonAutoProvider with ChangeNotifier {
  SearchSalonAutoModel post = SearchSalonAutoModel();

  getPostEntityNameData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    //notifyListeners();
    return post =
        (await SearchSalonAutoServices.getEntityNameService(url, body))!;
  }
}
