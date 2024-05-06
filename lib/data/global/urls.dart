import 'package:manager_projects_app/data/global/apis.dart';

class AppUrls{
  // Urls Tasks
  static String urlTasks = "${AppApis.apiLocal}/tasks";
  //static String Function(int idUser) urlListTasksByUserId = (int idUser) => "$urlTasks/user/$idUser";
  
  // Urls Projects
  static String urlProjects = "${AppApis.apiLocal}/projects";

  // Urls Users
  static String urlUsers = "${AppApis.apiLocal}/users";
  // Urls Filters
  static String urlFilters = "${AppApis.apiLocal}/filters/tasksAndProyects";
}