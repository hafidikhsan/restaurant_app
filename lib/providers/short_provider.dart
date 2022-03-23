import 'package:flutter/material.dart';

class ShortProvider with ChangeNotifier {
  String _queryKey = '';

  String get queryKey => _queryKey;

  set queryKey(String value) {
    _queryKey = value;
    notifyListeners();
  }
}
