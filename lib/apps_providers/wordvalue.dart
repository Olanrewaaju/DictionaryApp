import 'package:flutter/widgets.dart';

class Wordvalue extends ChangeNotifier {
  String _word = '';
  String get word => _word;

  void wordChanger(String parameter) {
    _word = parameter;
    notifyListeners();
  }
}
