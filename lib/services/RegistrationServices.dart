import 'dart:convert';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:style_buddy/models/RegistrationModel.dart';

class RegistrationServices {
  static Future<RegistrationModel?> userRegisterService(
      String url, Object body) async {
    RegistrationModel? result;

    var headers = {'Content-Type': 'application/json'};

    print('servicePayload :- ${json.encode(body)}');

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(body), headers: headers);

      print('serviceResponse :- $response');

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = RegistrationModel.fromJson(item);
        Loader.hide();
      } else {
        print('Error :- ${result!.status}');
        Loader.hide();
        Fluttertoast.showToast(msg: "${result.status}");
      }
    } catch (error) {
      print('cacheError :- $error');
      Loader.hide();
      Fluttertoast.showToast(msg: "$error");
    }
    return result;
  }
}
