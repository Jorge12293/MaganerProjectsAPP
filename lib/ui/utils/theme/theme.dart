import 'package:flutter/material.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';

ThemeData buildAppTheme() => ThemeData(
      fontFamily: 'Montserrat',
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondary),
      useMaterial3: true,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.secondary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return AppColors.contentColorWhite;
        },
      ), backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.contentColorGrey;
          }
          return AppColors.secondary;
        },
      ))),
    );
