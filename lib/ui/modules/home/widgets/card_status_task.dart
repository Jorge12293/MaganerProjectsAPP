import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/enums/status.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';

class CardStatusTask extends StatelessWidget {
  final Task task;
  const CardStatusTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Status.todo == task.status
            ? Column(
                children: [
                  Icon(Icons.pending,
                      color: getColorStatusTodo(task, Status.todo)),
                  const Text('Por hacer',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              )
            : const SizedBox.shrink(),
        Status.inProgress == task.status
            ? Column(
                children: [
                  Icon(Icons.work_history,
                      color: getColorStatusProgress(task, Status.inProgress)),
                  const Text('En progreso',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              )
            : const SizedBox.shrink(),
        Status.completed == task.status
            ? Column(
                children: [
                  Icon(Icons.check_circle,
                      color: getColorStatusComplete(task, Status.completed)),
                  const Text('Completada',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
