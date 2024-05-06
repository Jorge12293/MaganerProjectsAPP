
import 'dart:convert';

import 'package:manager_projects_app/infrastructure/domain/models/project.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';

class FilterDataResponse {
    List<Project> listProject;
    List<Task> listTask;

    FilterDataResponse({
        required this.listProject,
        required this.listTask,
    });

    factory FilterDataResponse.fromRawJson(String str) => FilterDataResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FilterDataResponse.fromJson(Map<String, dynamic> json) => FilterDataResponse(
        listProject: List<Project>.from(json["listProject"].map((x) => Project.fromJson(x))),
        listTask: List<Task>.from(json["listTask"].map((x) => Task.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "listProject": List<dynamic>.from(listProject.map((x) => x.toJson())),
        "listTask": List<dynamic>.from(listTask.map((x) => x.toJson())),
    };
}