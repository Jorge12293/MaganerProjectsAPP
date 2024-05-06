import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/models/project.dart';

class ProjectProvider with ChangeNotifier {
  
  List<Project> _listProject = [];
  List<Project> get listProject => _listProject;
  set listProject(List<Project> value) {
    _listProject = value;
    notifyListeners();
  }

  addProject(Project value) {
    _listProject = [value, ..._listProject];
    notifyListeners();
  }

  updateProject(Project value) {
    _listProject = _listProject.map((p) {
      if (p.projectId == value.projectId) return value;
      return p;
    }).toList();
    notifyListeners();
  }

  deleteProject(int id) {
    _listProject = _listProject.where((p) => p.projectId != id).toList();
    notifyListeners();
  }
}
