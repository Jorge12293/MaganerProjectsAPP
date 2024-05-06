import 'dart:developer';
import 'package:manager_projects_app/infrastructure/domain/dto/task_update_status_dto.dart';
import 'package:manager_projects_app/infrastructure/repositories_local/user_local_repository.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/loader_projects.dart';
import 'package:manager_projects_app/ui/widgets/dialog_information_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/enums/status.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';
import 'package:manager_projects_app/infrastructure/repositories/task_repository.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/container_button_status.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/title_box_status.dart';
import 'package:manager_projects_app/ui/provider/task_select_provider.dart';
import 'package:manager_projects_app/ui/utils/methods/functions_string.dart';
import 'package:manager_projects_app/ui/widgets/snack_bart_custom.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';

class ListTaskView extends StatefulWidget {
  final bool? isModal;
  const ListTaskView({super.key, this.isModal});

  @override
  State<ListTaskView> createState() => _ListTaskViewState();
}

class _ListTaskViewState extends State<ListTaskView> {
  bool isLoadApp = true;
  List<Status> listItemsStatus = [...Status.values];

  @override
  void initState() {
    super.initState();
    loadDataApp();
  }

  loadDataApp() async {
    try {
      setState(() {
        isLoadApp = true;
      });
      final user =  await UserLocalRepository.getUser();
      final dataTask = await TaskRepository.listTasksByUserId(user?.userId ?? 1);
      if (!dataTask.success) {
        showMessageErrorHandle(dataTask.message);
        return;
      }
      updateListMyTasks(dataTask.data);
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isLoadApp = false;
      });
    }
  }

  updateListMyTasks(List<Task> data) {
    final taskSelectProvider =
        Provider.of<TaskSelectProvider>(context, listen: false);
    taskSelectProvider.statusSelect = null;
    taskSelectProvider.listTask = data;
  }

  showMessageErrorHandle(String messageError) {
    showSnackBarMessageError(context, messageError);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadApp) return const LoaderProject();
    final taskSelectProvider = Provider.of<TaskSelectProvider>(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.contentColorGrey2)),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TitleBoxStatus(statusSelect: taskSelectProvider.statusSelect),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ...listItemsStatus
                      .map((status) => ContainerButtonStatus(
                            status: status,
                            statusSelect: taskSelectProvider.statusSelect,
                            onTap: () {
                              if (taskSelectProvider.statusSelect == status) {
                                taskSelectProvider.statusSelect = null;
                              } else {
                                taskSelectProvider.statusSelect = status;
                              }
                            },
                          ))
                      .toList(),
                ]),
              )
            ],
          ),
        ),
        const ListMyTasks()
      ],
    );
  }
}

class ListMyTasks extends StatelessWidget {
  const ListMyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final taskSelectProvider = Provider.of<TaskSelectProvider>(context);
    final List<Task> filteredTasks = taskSelectProvider.listTask
        .where((element) =>
            taskSelectProvider.statusSelect == null ||
            element.status == taskSelectProvider.statusSelect)
        .toList();
    final bool hasTasks = filteredTasks.isNotEmpty;

    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            if (!hasTasks) const Text('No hay tareas'),
            if (hasTasks && filteredTasks.isEmpty) const Text('No hay tareas'),
            ...filteredTasks
                .map((task) => CardMyTask(task: task))
          ],
        ),
      ),
    );
  }
}

class CardMyTask extends StatelessWidget {
  final Task task;

  const CardMyTask({Key? key, required this.task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(task.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 5),
            Text(task.description),
            if (task.project != null) ...[
              const Divider(),
              Text(
                task.project!.name,
                textAlign: TextAlign.start,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(task.project!.description),
            ],
           const Divider(),
            Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BuildStatusButton(
                          status: Status.todo,
                          iconData: Icons.pending,
                          task: task),
                      BuildStatusButton(
                          status: Status.inProgress,
                          iconData: Icons.work_history,
                          task: task),
                      BuildStatusButton(
                          status: Status.completed,
                          iconData: Icons.check_circle,
                          task: task),
                    ],
                  )
          
          ],
        ),
      ),
    );
  }
}

class BuildStatusButton extends StatefulWidget {
  final Status status;
  final IconData iconData;
  final Task task;
  const BuildStatusButton(
      {super.key,
      required this.status,
      required this.iconData,
      required this.task});

  @override
  State<BuildStatusButton> createState() => _BuildStatusButtonState();
}

class _BuildStatusButtonState extends State<BuildStatusButton> {

  Future<void> _showLoaderDialog( int idTask, TaskUpdateStatusDto taskDto, Task task) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return dialogLoading("Actualizando estado");
      },
    );

    try {
      final respData = await TaskRepository.updateStatusTask(idTask, taskDto);
      if (!respData.success || respData.data == null) {
        showMessageError("Error", respData.message);
        return;
      }
      changeValueStatus(taskDto.status, task);
    } catch (e) {
      log(e.toString());
      showMessageError("Error", "Intente más tarde.");
    } finally {
      closeDialog(); // Cierra el diálogo emergente
    }
  }

  showMessageError(String title, String description) {
    showDialogError(context: context, title: title, description: description);
  }

  closeDialog() {
    Navigator.of(context).pop(); // Cierra el diálogo emergente
  }

  changeValueStatus(Status status, Task task) {
    final taskSelectProvider =
        Provider.of<TaskSelectProvider>(context, listen: false);
    taskSelectProvider.updateStatusTask(task, status);
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.task.status == widget.status;
    return Column(
      children: [
        Text(
          statusToString(widget.status),
          style: TextStyle(fontWeight: isSelected ? FontWeight.bold : null),
        ),
        IconButton(
          onPressed: () {
            _showLoaderDialog(widget.task.taskId ?? 0,
                TaskUpdateStatusDto(status: widget.status), widget.task);
          },
          icon: Icon(widget.iconData),
          color: isSelected ? getColorStatus(widget.status, widget.task) : null,
        ),
      ],
    );
  }
}
