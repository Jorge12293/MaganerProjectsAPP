import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/enums/status.dart';

class TitleBoxStatus extends StatelessWidget {
  final Status? statusSelect;

  const TitleBoxStatus({super.key, required this.statusSelect});

  @override
  Widget build(BuildContext context) {
    double withScreen = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: withScreen / 1.1,
        child: Text(
            'Estados de tareas ${statusSelect == null ? '(TODAS)' : fromStatusText(statusSelect!)}'
                .toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

