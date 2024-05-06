import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/models/project.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';
import 'package:manager_projects_app/infrastructure/domain/models/user_app.dart';

class ProjectSelectProvider with ChangeNotifier {
  Project? _project;
  Project? get project => _project;

  set project(Project? value) {
    _project = value;
    notifyListeners();
  }

  updateProject(Project value) {
    if (_project != null) {
      _project?.name = value.name;
      _project?.description = value.description;
      notifyListeners();
    }
  }
  
  addTaskOfProject(Task value) {
    if (_project != null) {
      _project?.tasks = [value,..._project?.tasks ?? []];
      notifyListeners();
    }
  }

  updateTaskOfProject(Task value) {
    if (_project != null && _project?.tasks != null ) {
      _project?.tasks =  _project?.tasks?.map((task){
        if(task.taskId == value.taskId) { 
          task.title = value.title;
          task.description = value.description;
        }
        return task; 
      }).toList();
      notifyListeners();
    }
  }

  deleteTaskOfProject(int idTask) {
    if (_project != null && _project?.tasks != null ) {
      _project?.tasks =  _project?.tasks?.where((task)=>task.taskId != idTask).toList();
      notifyListeners();
    }
  }

  assignUserTaskOfProject(int taskId, UserApp user) {
    if (_project != null && _project?.tasks != null ) {
      _project?.tasks =  _project?.tasks?.map((task){
        if(task.taskId == taskId) { 
          task.user = user;
          task.userId = user.userId;
        }
        return task; 
      }).toList();
      notifyListeners();
    }
  }
}
