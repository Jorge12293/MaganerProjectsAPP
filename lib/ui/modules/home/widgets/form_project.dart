import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/models/project.dart';
import 'package:manager_projects_app/infrastructure/repositories/project_repository.dart';
import 'package:manager_projects_app/ui/provider/project_provider.dart';
import 'package:manager_projects_app/ui/provider/project_select_provider.dart';
import 'package:manager_projects_app/ui/utils/methods/functions_string.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';
import 'package:manager_projects_app/ui/widgets/dialog_information_widget.dart';
import 'package:manager_projects_app/ui/widgets/form_widget.dart';
import 'package:provider/provider.dart';

class FormProject extends StatefulWidget {
  final Project? project;
  const FormProject({super.key, required this.project});
  @override
  State<FormProject> createState() => _FormProjectState();
}

class _FormProjectState extends State<FormProject> {
  final _formKey = GlobalKey<FormState>();
  bool isLoadingApp = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      nameController.text = widget.project?.name ?? "";
      descriptionController.text = widget.project?.description ?? "";
    }
  }

  onAddProject() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      setState(() {
        isLoadingApp = true;
      });
      Project newProject = getModelProject();

      final respData = await (widget.project == null
          ? ProjectRepository.addProject(newProject)
          : ProjectRepository.updateProject(
              widget.project!.projectId ?? 0, newProject));

      if (!respData.success || respData.data == null) {
        showMessageError("Error", respData.message);
        return;
      }
      if (widget.project == null) {
        saveProject(respData.data!);
      } else {
        updateProject(respData.data!);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isLoadingApp = false;
      });
    }
  }

  saveProject(Project project) {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    projectProvider.addProject(project);
    Navigator.of(context).pop(project);
  }

  updateProject(Project project) async {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    final selectProjectProvider =
        Provider.of<ProjectSelectProvider>(context, listen: false);
    projectProvider.updateProject(project);
    selectProjectProvider.updateProject(project);
    Navigator.of(context).pop(project);
  }

  showMessageError(String title, String description) {
    showDialogError(context: context, title: title, description: description);
  }

  Project getModelProject() => Project(
      name: capitalizeFirstLetter(nameController.text),
      description: capitalizeFirstLetter(descriptionController.text));

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
                    widget.project == null
                        ? "Nuevo Proyecto"
                        : "Actualizar Proyecto".toUpperCase(),
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
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese nombre';
                }
                return null;
              },
              decoration: inputDecoration(hintText: 'Nombre'),
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
                onPressed: !isLoadingApp ? () => onAddProject() : null,
                child: isLoadingApp
                    ? const CircularProgressIndicator(
                        color: AppColors.contentColorWhite)
                    : Text(widget.project == null ? "Crear" : "Actualizar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
