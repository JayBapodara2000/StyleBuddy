import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class StylebuddyPreferences {
  final String deviceId = "deviceId";
  final String deviceMac = "deviceMac";
  final String isLogeed = "isLogeed";
  final String userId = "userId";
  final String custId = "custId";
  final String styleMasterId = "styleMasterId";
  final String token = "token";
  final String countryName = "countryName";
  final String cityName = "cityName";
  final String currentAddress = "currentAddress";
  final String username = "username";

  Future<String> getDeviceId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(deviceId) ?? "";
  }

  Future<dynamic> setDeviceId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(deviceId, value);
  }

  Future<dynamic> setIsUserLogged(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(isLogeed, value);
  }

  Future<bool> getIsUserLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(isLogeed) ?? false;
  }

  Future<dynamic> setDeviceMac(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(deviceMac, value);
  }

  Future<String> getDeviceMac() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(deviceMac) ?? "";
  }

  Future<dynamic> setUserId(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(userId, value);
  }

  Future<int> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(userId) ?? 0;
  }

  Future<dynamic> setCustId(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(custId, value);
  }

  Future<int> getCustId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(custId) ?? 0;
  }

  Future<dynamic> setStyleMasterId(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(styleMasterId, value);
  }

  Future<int> getStyleMasterId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(styleMasterId) ?? 0;
  }

  Future<dynamic> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(token, value);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(token) ?? "";
  }

  Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(username) ?? "";
  }

  Future<dynamic> setUsername(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(username, value);
  }

  Future<dynamic> setCountryName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(currentAddress, value);
  }

  Future<String> getCountryName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(currentAddress) ?? "";
  }

  Future<dynamic> setCityName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(cityName, value);
  }

  Future<String> getCityName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(cityName) ?? "";
  }

  Future<dynamic> setCurrentAdd(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(countryName, value);
  }

  Future<String> getCurrentAdd() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(countryName) ?? "";
  }
  //clear all local storage store data

  Future<bool> clearAllSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.clear();
  }
}
