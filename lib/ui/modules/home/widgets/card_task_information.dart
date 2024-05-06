import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/card_status_task.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';

class CardTaskInformation extends StatelessWidget {
  final Task task;
  final void Function() onPressedShowCustomer;
  final void Function() onPressedShowTask;
  final void Function() onPressedDeleteTask;
  const CardTaskInformation(
      {super.key,
      required this.task,
      required this.onPressedShowCustomer,
      required this.onPressedShowTask,
      required this.onPressedDeleteTask});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardStatusTask(task: task),
                  task.userId != null
                      ? CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.green.shade100,
                          child: IconButton(
                              onPressed: onPressedShowCustomer,
                              icon: const Icon(Icons.person_pin,
                                  size: 25,
                                  color: AppColors.contentColorGreen)))
                      : CircleAvatar(
                          radius: 20,
                          child: IconButton(
                              onPressed: onPressedShowCustomer,
                              icon: const Icon(Icons.person_add,
                                  size: 25,
                                  color: AppColors.contentColorBlue))),
                  CircleAvatar(
                      radius: 20,
                      child: IconButton(
                          onPressed: onPressedDeleteTask,
                          icon: const Icon(Icons.delete,
                              size: 25, color: AppColors.contentColorRed)))
                ],
              ),
              const Divider(),
              SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: onPressedShowTask,
                          child: Column(
                            children: [
                              Text(task.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: AppColors.contentColorBlack,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text(task.description,
                                  textAlign: TextAlign.center),
                            ],
                          )),
                    ],
                  )),
              task.userId != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Divider(),
                        Text(task.user!.username.toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        Text(task.user!.email.toLowerCase(),
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center)
                      ],
                    )
                  : const SizedBox.shrink()
            ],
          )),
    );
  }
}
