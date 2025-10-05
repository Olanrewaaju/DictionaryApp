import 'package:flutter/material.dart';

class Usernamenotif extends ChangeNotifier {
  String _username = '';

  String get username => _username;

  /// Update the stored username and notify listeners.
  void newname(String updatedName) {
    _username = updatedName;
    notifyListeners();
  }
}
