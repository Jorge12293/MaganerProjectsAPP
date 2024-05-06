import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/enums/status.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';

class AppColors {
  static const Color primary = contentColorBlack;
  static const Color secondary = contentColorGreyOpacity;

  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorGrey = Colors.grey;
  static const Color contentColorGrey2 = Color.fromARGB(255, 187, 187, 187);
  static const Color contentColorGreyOpacity = Color.fromARGB(255, 55, 57, 62);
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Colors.green;
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

Color getColorStatusTodo(Task task, Status status) {
  return status == task.status
      ? AppColors.contentColorYellow
      : AppColors.contentColorBlack;
}

Color getColorStatusProgress(Task task, Status status) {
  return status == task.status
      ? AppColors.contentColorOrange
      : AppColors.contentColorBlack;
}

Color getColorStatusComplete(Task task, Status status) {
  return status == task.status
      ? AppColors.contentColorGreen
      : AppColors.contentColorBlack;
}

  Color? getColorStatus(Status status,Task task) {
    switch (status) {
      case Status.todo:
        return getColorStatusTodo(task, Status.todo);
      case Status.inProgress:
        return getColorStatusProgress(task, Status.inProgress);
      case Status.completed:
        return getColorStatusComplete(task, Status.completed);
      default:
        return null;
    }
  }