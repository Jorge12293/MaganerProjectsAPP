import 'package:flutter/material.dart';
import 'package:manager_projects_app/ui/modules/home/pages/home_page.dart';
import 'package:manager_projects_app/ui/modules/home/pages/form_project_page.dart';
import 'package:manager_projects_app/ui/modules/auth/pages/auth_page.dart';
import 'package:manager_projects_app/ui/routes/routes_name.dart';

class AppRoutes {
  
  static const initialRouteAuth = RoutesName.home;
  static const initialRouteNotAuth = RoutesName.auth;

  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesName.home: (context) => const HomePage(),
    RoutesName.auth: (context) => const AuthPage(),
    RoutesName.formProject: (context) => const FormProjectPage(),
  };
}
