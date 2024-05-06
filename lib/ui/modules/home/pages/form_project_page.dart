import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/models/project.dart';
import 'package:manager_projects_app/ui/modules/home/views/project_view.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/form_project.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';
import 'package:manager_projects_app/ui/widgets/snack_bart_custom.dart';

class FormProjectPage extends StatefulWidget {
  const FormProjectPage({super.key});

  @override
  State<FormProjectPage> createState() => _FormProjectPageState();
}

class _FormProjectPageState extends State<FormProjectPage> {
  
  
  openModalProject(Project? project) async {
    if(project == null) return;
    final data = await showDialog<Project?>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return  AlertDialog(content: FormProject(project: project));
      },
    );
    if (data != null) {
      showMessage("Proyecto Actualizado");
    }
  }
  
  
  showMessage(String message) {
    showSnackBarMessage(context,message);
  }
  
  
  @override
  Widget build(BuildContext context) {
    Project? project;
    final argProject = ModalRoute.of(context)!.settings.arguments;
    if (argProject != null) {
      project = argProject as Project;
    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.contentColorWhite),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Proyecto",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.contentColorWhite)),
              CircleAvatar(
                  child: IconButton(
                      onPressed: () =>openModalProject(project),
                      icon: const Icon(Icons.edit,
                          color: AppColors.contentColorBlack)))
            ],
          ),
        ),
        body: ProjectView(project: project));
  }
}
