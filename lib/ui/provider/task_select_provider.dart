import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/enums/status.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';

class TaskSelectProvider with ChangeNotifier {
  List<Task> _listTask = [];
  List<Task> get listTask => _listTask;
  set listTask(List<Task> value) {
    _listTask = value;
    notifyListeners();
  }

  Status? _statusSelect;
  Status? get statusSelect => _statusSelect;
  set statusSelect(Status? value) {
    _statusSelect = value;
    notifyListeners();
  }

  updateStatusTask(Task value, Status status) {
    _listTask = _listTask.map((t) {
      if (t.taskId == value.taskId) {
        t.status = status;
      }
      return t;
    }).toList();
    _statusSelect = status;
    notifyListeners();
  }
}
