import 'package:flutter/material.dart';

class ShortProvider with ChangeNotifier {
  bool _short = false;

  bool get short => _short;

  set short(bool index) {
    _short = index;
    notifyListeners();
  }
}
