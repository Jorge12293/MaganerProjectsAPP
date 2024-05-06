import 'dart:convert';

import 'package:manager_projects_app/infrastructure/domain/models/task.dart';

List<Project> responseListProjectFromJson(String str) => List<Project>.from(json.decode(str).map((x) => Project.fromJson(x)));

class Project {
  
    int? projectId;
    String name;
    String description;
    List<Task>? tasks;

    Project({
        this.projectId,
        required this.name,
        required this.description,
        this.tasks
    });

    factory Project.fromRawJson(String str) => Project.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Project.fromJson(Map<String, dynamic> json){

  return Project(
        projectId: json["projectId"],
        name: json["name"],
        description: json["description"],
        tasks:json["tasks"] != null ? List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))) : null,
    );

    } 

    Map<String, dynamic> toJson() => {
        "projectId": projectId,
        "name": name,
        "description": description,
        "tasks": tasks!=null ? List<Task>.from(tasks!.map((x) => x.toJson())) : null
    };
}

