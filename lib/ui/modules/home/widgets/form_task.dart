import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/enums/status.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';
import 'package:manager_projects_app/infrastructure/repositories/task_repository.dart';
import 'package:manager_projects_app/ui/provider/project_select_provider.dart';
import 'package:manager_projects_app/ui/utils/methods/functions_string.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';
import 'package:manager_projects_app/ui/widgets/dialog_information_widget.dart';
import 'package:manager_projects_app/ui/widgets/form_widget.dart';
import 'package:provider/provider.dart';

class FormTask extends StatefulWidget {
  final int idProject;
  final Task? task;
  const FormTask({super.key, required this.idProject, required this.task});
  @override
  State<FormTask> createState() => _FormTaskState();
}

class _FormTaskState extends State<FormTask> {
  final _formKey = GlobalKey<FormState>();
  bool isLoadingApp = false;

  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      taskController.text = widget.task?.title ?? "";
      descriptionController.text = widget.task?.description ?? "";
    }
  }

  onAddTask() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      setState(() {
        isLoadingApp = true;
      });
      Task newTask = getModelTask();

      final respData = await (widget.task == null
          ? TaskRepository.addTask(newTask)
          : TaskRepository.updateTask(widget.task!.taskId ?? 0, newTask));

      if (!respData.success || respData.data == null) {
        showMessageError("Error", respData.message);
        return;
      }
      if (widget.task == null) {
        saveTask(respData.data!);
      } else {
        updateTask(respData.data!);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isLoadingApp = false;
      });
    }
  }

  saveTask(Task task) {
    final selectProjectProvider = Provider.of<ProjectSelectProvider>(context, listen: false);
    selectProjectProvider.addTaskOfProject(task);
    Navigator.of(context).pop(task);
  }

  updateTask(Task task) {
    final selectProjectProvider =
        Provider.of<ProjectSelectProvider>(context, listen: false);
    ;
    selectProjectProvider.updateTaskOfProject(task);
    Navigator.of(context).pop(task);
  }

  showMessageError(String title, String description) {
    showDialogError(context: context, title: title, description: description);
  }

  Task getModelTask() => Task(
        title: capitalizeFirstLetter(taskController.text),
        description: capitalizeFirstLetter(descriptionController.text),
        projectId: widget.idProject,
        status: Status.todo,
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    widget.task == null
                        ? "Nuevo Tarea"
                        : "Actualizar Tarea".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap:
                      !isLoadingApp ? () => Navigator.of(context).pop() : null,
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.close_rounded,
                      size: 35,
                    ),
                  ),
                )
              ],
            ),
            sizedBoxHeightMedium(),
            TextFormField(
              enabled: !isLoadingApp,
              controller: taskController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese tarea';
                }
                return null;
              },
              decoration: inputDecoration(hintText: 'Tarea'),
            ),
            sizedBoxHeightMedium(),
            TextFormField(
              enabled: !isLoadingApp,
              minLines: 3,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese descripción';
                }
                return null;
              },
              decoration: inputDecoration(hintText: 'Descripcion'),
            ),
            sizedBoxHeightSmall(),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: !isLoadingApp ? () => onAddTask() : null,
                child: isLoadingApp
                    ? const CircularProgressIndicator(
                        color: AppColors.contentColorWhite)
                    : Text(widget.task == null ? "Crear" : "Actualizar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
