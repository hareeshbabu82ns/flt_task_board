import 'package:flutter/material.dart';

class TaskSearchQuery with ChangeNotifier {
  String _query = '';
  bool isQueryRunning = false;

  String get query => _query;

  set query(String query) {
    _query = query;
    notifyListeners();
  }
}
