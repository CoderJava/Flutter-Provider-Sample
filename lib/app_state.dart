import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppState with ChangeNotifier {

  AppState();

  String _displayText = "";
  String _jsonResponse = "";
  String _dataUrl = "https://reqres.in/api/users?per_page=20";
  bool _isFetching = false;

  void setDisplayText(String text) {
    _displayText = text;
    notifyListeners();
  }

  String get getDisplayText {
    return _displayText;
  }

  bool get isFetching {
    return _isFetching;
  }

  Future<void> fetchData() async {
    _isFetching = true;
    notifyListeners();

    var response = await http.get(_dataUrl);
    if (response.statusCode == 200) {
      _jsonResponse = response.body;
    }

    _isFetching = false;
    notifyListeners();
  }

  String get getResponseText {
    return _jsonResponse;
  }

  List<dynamic> getResponseJson() {
    if (_jsonResponse.isNotEmpty) {
      Map<String, dynamic> json = jsonDecode(_jsonResponse);
      return json['data'];
    }
    return null;
  }
}
