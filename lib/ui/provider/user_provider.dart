import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/models/user_app.dart';

class UserProvider with ChangeNotifier {
  
  List<UserApp> _listUserApp = [];
  List<UserApp> get listUserApp => _listUserApp;
  set listUserApp(List<UserApp> value) {
    _listUserApp = value;
    notifyListeners();
  }
}
