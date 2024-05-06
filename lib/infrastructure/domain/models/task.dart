import 'dart:convert';

import 'package:manager_projects_app/infrastructure/domain/enums/status.dart';
import 'package:manager_projects_app/infrastructure/domain/models/project.dart';
import 'package:manager_projects_app/infrastructure/domain/models/user_app.dart';

List<Task> responseListTaskFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

class Task {
  int? taskId;
  String title;
  String description;
  Status status;
  int projectId;
  int? userId;
  UserApp? user;
  Project? project;


  Task({
    this.taskId,
    required this.title,
    required this.description,
    required this.status,
    required this.projectId,
    this.userId,
    this.user,
    this.project,
  });

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskId: json["taskId"],
        title: json["title"],
        description: json["description"],
        status: fromStringStatus(json["status"]),
        projectId: json["projectId"],
        userId: json["userId"],
        user: json["user"] == null ? null : UserApp.fromJson(json["user"]),
        project: json["project"] == null ? null : Project.fromJson(json["project"]),
      );

  Map<String, dynamic> toJson() => {
        "taskId": taskId,
        "title": title,
        "description": description,
        "status": status.value,
        "projectId": projectId,
        "userId": userId,
        "user": user?.toJson(),
        "project": project?.toJson(),
      };
}
