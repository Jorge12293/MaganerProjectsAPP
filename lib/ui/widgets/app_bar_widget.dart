import 'package:flutter/material.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';

AppBar appBar(String title) {
  return AppBar(
    iconTheme: const IconThemeData(color: AppColors.contentColorWhite),
    title: Text(title, style: const TextStyle(color: AppColors.contentColorWhite)),
  );
}
