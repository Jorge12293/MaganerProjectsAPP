import 'package:flutter/material.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';

showSnackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
           backgroundColor: AppColors.contentColorGreen,
      content: Text(message),
    ),
  );
}

showSnackBarMessageError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.contentColorRed,
      content: Text(message),
    ),
  );
}
