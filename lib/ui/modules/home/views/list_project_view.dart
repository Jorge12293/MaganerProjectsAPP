import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/loader_projects.dart';
import 'package:provider/provider.dart';
import 'package:manager_projects_app/infrastructure/domain/models/project.dart';
import 'package:manager_projects_app/infrastructure/repositories/project_repository.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/card_project.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/form_project.dart';
import 'package:manager_projects_app/ui/provider/project_provider.dart';
import 'package:manager_projects_app/ui/widgets/snack_bart_custom.dart';

class ListProjectView extends StatefulWidget {
  const ListProjectView({super.key});
  @override
  State<ListProjectView> createState() => _ListProjectViewState();
}

class _ListProjectViewState extends State<ListProjectView> {
  bool isLoadApp = true;
  @override
  void initState() {
    super.initState();
    loadDataApp();
  }

  loadDataApp() async {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    try {
      setState(() {
        isLoadApp = true;
      });
      final dataProjects = await ProjectRepository.listProjects();
      if (!dataProjects.success) {
        showMessageErrorHandle(dataProjects.message);
        return;
      }
      projectProvider.listProject = [...dataProjects.data];
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isLoadApp = false;
      });
    }
  }

  showMessageErrorHandle(String messageError) {
    showSnackBarMessageError(context, messageError);
  }

  openModalProject() async {
    final data = await showDialog<Project?>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const AlertDialog(content: FormProject(project: null));
      },
    );
    if (data != null) {
      showMessage("Nuevo proyecto agregado");
    }
  }

  showMessage(String message) {
    showSnackBarMessage(context, message);
  }

  @override
  Widget build(BuildContext context) {
    double withScreen = MediaQuery.of(context).size.width;
    if (isLoadApp) return const LoaderListProject();

    final provider = Provider.of<ProjectProvider>(context);

    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: Column(
            children: [
              provider.listProject.isEmpty
                  ? const Text('No hay proyectos')
                  : const SizedBox.shrink(),
              ...provider.listProject
                  .map((project) => CardProject(project: project))
                  .toList()
            ],
          ),
        )),
        Center(
            child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: withScreen / 1.4,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => openModalProject(),
                    child: const Text('Agregar Proyecto',
                        style: TextStyle(fontSize: 14))))),
      ],
    );
  
  }
}


