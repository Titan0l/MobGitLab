import 'package:flutter/material.dart';

class StringDrop with ChangeNotifier {
  String _textDrop='';  String get textDrop => _textDrop; 
  void set textDrop (String value) {
    _textDrop = value;
    notifyListeners();  
  }
}
