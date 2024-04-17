import 'package:flutter/material.dart';

class UrlProvider extends ChangeNotifier {
  String _url = 'https://ab9b-182-2-52-245.ngrok-free.app/';

  String get url => _url;

  void updateUrl(String newUrl) {
    _url = newUrl;
    notifyListeners();
  }
}