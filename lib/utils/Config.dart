import 'dart:core';

class Config {
  static String strBaseURL =
      "https://ckgk0oab76.execute-api.ap-south-1.amazonaws.com/";
  static String envVariable = "QA/";

  static String? token = null;
  static var httpGetHeader = {
    "Access-Control-Allow-Origin": "*",
    "Accept": "application/json",
    "Content-type": "application/json"
  };

  static var httpImageGetHeader = {
    "Accept": "*/*",
  };

  static var httpPostHeader = {
    "Access-Control-Allow-Origin": "*",
    "Accept": "application/json",
    "Content-type": "application/json"
  };

  static var httpPostHeaderForEncode = {
    "Access-Control-Allow-Origin": "*",
    "Accept": "application/json",
    "Content-type": "application/x-www-form-urlencoded"
  };
}
