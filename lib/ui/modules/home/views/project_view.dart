import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';
import 'package:manager_projects_app/infrastructure/domain/models/user_app.dart';
import 'package:manager_projects_app/infrastructure/repositories/task_repository.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/card_task_information.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/loader_projects.dart';
import 'package:manager_projects_app/ui/provider/project_provider.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';
import 'package:manager_projects_app/ui/widgets/dialog_information_widget.dart';
import 'package:provider/provider.dart';
import 'package:manager_projects_app/infrastructure/domain/models/project.dart';
import 'package:manager_projects_app/infrastructure/repositories/project_repository.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/form_task.dart';
import 'package:manager_projects_app/ui/provider/project_select_provider.dart';
import 'package:manager_projects_app/ui/widgets/snack_bart_custom.dart';
import 'package:manager_projects_app/ui/widgets/user_list.dart';

class ProjectView extends StatefulWidget {
  final Project? project;
  const ProjectView({super.key, required this.project});

  @override
  State<ProjectView> createState() => _FormOrderViewState();
}

class _FormOrderViewState extends State<ProjectView> {
  bool isLoadApp = true;

  @override
  void initState() {
    super.initState();
    loadDataInitial();
  }

  loadDataInitial() async {
    final selectProjectProvider = Provider.of<ProjectSelectProvider>(context, listen: false);
    try {
      setState(() {
        isLoadApp = true;
      });
      final dataProject =
          await ProjectRepository.getProject(widget.project!.projectId ?? 0);
      if (!dataProject.success) {
        showMessageErrorHandle(dataProject.message);
        selectProjectProvider.project = null;
        return;
      }
      selectProjectProvider.project = dataProject.data;
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isLoadApp = false;
      });
    }
  }

  Future<void> onAssignUserTask(Task task, UserApp user) async {
    await showLoadingDialog("Asignando usuario", context);
    try {
      final dataTask = await TaskRepository.updateTask(task.taskId ?? 0, task);
      if (!dataTask.success || dataTask.data == null) {
        showMessageErrorHandle(dataTask.message);
        return;
      }
      assignUserTask(task.taskId ?? 0, user);
    } catch (e) {
      log("Ocurrió un error intente más tarde");
      showMessageErrorHandle(e.toString());
    } finally {
      closeDialog();
    }
  }

  Future<void> onDeleteProject(int? idProject) async {
    if (idProject == null) {
      return;
    }
    await showLoadingDialog("Eliminando proyecto", context);
    try {
      final dataTask = await ProjectRepository.deleteProject(idProject);
      if (!dataTask.success || dataTask.data == null) {
        showMessageErrorHandle(dataTask.message);
        return;
      }
      deleteProject(idProject);
    } catch (e) {
      log("Ocurrió un error intente más tarde");
      showMessageErrorHandle(e.toString());
    } finally {
      closeDialog();
    }
  }

  Future<void> deleteTask(int? idTask) async {
    if (idTask == null) {
      return;
    }
    await showLoadingDialog("Eliminando usuario", context);
    try {
      final dataTask = await TaskRepository.deleteTask(idTask);
      if (!dataTask.success || dataTask.data == null) {
        showMessageErrorHandle(dataTask.message);
        return;
      }
      deleteUserTask(idTask);
    } catch (e) {
      log("Ocurrió un error intente más tarde");
      showMessageErrorHandle(e.toString());
    } finally {
      closeDialog();
    }
  }


  openModalShowCustomer(Task task) async {
    final data = await showDialog<UserApp>(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(content: UserList(task: task));
      },
    );
    if (data != null) {
      Task newTask = Task(
          taskId: task.taskId,
          title: task.title,
          description: task.description,
          status: task.status,
          projectId: task.projectId,
          userId: data.userId,
          user: data);
      onAssignUserTask(newTask, data);
    }
  }

  openModalTask(Task? task) async {
    final data = await showDialog<Task?>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
            content: FormTask(
                idProject: widget.project?.projectId ?? 0, task: task));
      },
    );
    if (data != null && task != null) {
      showMessage("Tarea Actualizada");
    }
    if (data != null && task == null) {
      showMessage("Tarea Creada");
    }
  }

  showMessage(String message) {
    showSnackBarMessage(context, message);
  }

  showMessageErrorHandle(String messageError) {
    showSnackBarMessageError(context, messageError);
  }

  assignUserTask(int taskId, UserApp user) {
    final selectProjectProvider = Provider.of<ProjectSelectProvider>(context, listen: false);
    selectProjectProvider.assignUserTaskOfProject(taskId, user);
    String nameUser = " ${user.username}".toUpperCase();
    showMessage("Tarea asignada a usuario : $nameUser");
  }

  deleteUserTask(int taskId) {
    final selectProjectProvider =Provider.of<ProjectSelectProvider>(context, listen: false);
    selectProjectProvider.deleteTaskOfProject(taskId);
    showMessage("Tarea eliminada");
  }


  deleteProject(int idProject) {
    final projectProvider =Provider.of<ProjectProvider>(context, listen: false);
    projectProvider.deleteProject(idProject);
    showMessage("Proyecto eliminado");
    closeDialog();
  }


  closeDialog() {
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    double withScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    if (isLoadApp) return const LoaderProject();

    final provider = Provider.of<ProjectSelectProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: heightScreen / 1.14,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: withScreen / 1.05,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Text(provider.project?.name ?? "Proyecto".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(provider.project?.description ?? "",
                            textAlign: TextAlign.center),
                        const SizedBox(height: 10, width: double.infinity)
                      ],
                    ),
                     Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                            child: IconButton(
                          onPressed:() async {
                              final resp = await dialogAccept(context,
                                  "¿Eliminar Proyecto?",
                                  "Está seguro que desea eliminar el proyecto");
                              if (resp) {
                                onDeleteProject(widget.project?.projectId ?? 0);
                              }
                          },
                          icon:const Icon(Icons.delete_outline,
                              color: AppColors.contentColorRed),
                        )))
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...provider.project!.tasks!
                        .map((task) => CardTaskInformation(
                            task: task,
                            onPressedShowTask: () => openModalTask(task),
                            onPressedShowCustomer: () => openModalShowCustomer(task),
                            onPressedDeleteTask: () async {
                              final resp = await dialogAccept(context,
                                  "¿Eliminar Tarea?",
                                  "Está seguro que desea eliminar la tarea");
                              if (resp) {
                                deleteTask(task.taskId);
                              }
                            }
                        ))
                        .toList()
                  ],
                ),
              )),
              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => openModalTask(null),
                      child: const Row(
                        children: [
                          Icon(Icons.add, size: 25),
                          SizedBox(width: 10),
                          Text('Agregar Tarea')
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
