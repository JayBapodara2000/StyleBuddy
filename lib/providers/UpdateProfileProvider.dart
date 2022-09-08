import 'package:flutter/material.dart';
import 'package:style_buddy/models/UpdateProfileModel.dart';
import 'package:style_buddy/services/UpdateProfileServices.dart';

class UpdateProfileProvider with ChangeNotifier {
  UpdateProfileModel post = UpdateProfileModel();

  getPostUpdateProfileData(String url, Object body) async {
    print("providerUrl :- $url");
    print("providerPayLoad :- $body");

    notifyListeners();
    return post =
        (await UpdateProfileServices.updateProfileService(url, body))!;
  }
}
