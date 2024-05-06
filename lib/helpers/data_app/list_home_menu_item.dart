import 'package:flutter/material.dart';
import 'package:manager_projects_app/ui/modules/home/views/list_project_view.dart';
import 'package:manager_projects_app/ui/modules/home/views/list_task_view.dart';
import 'package:manager_projects_app/ui/utils/class/home_menu_item.dart';

List<HomeMenuItem> listHomeMenuItem = [
  HomeMenuItem(
      tag: "project",
      title: "Proyectos",
      item: const ListProjectView(),
      icon: Icons.assignment_sharp),
  HomeMenuItem(
      tag: "task",
      title: "Mis Tareas",
      item: const ListTaskView(),
      icon: Icons.task)
];

