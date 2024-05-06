import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/models/filter_data.dart';
import 'package:manager_projects_app/infrastructure/domain/models/project.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';
import 'package:manager_projects_app/infrastructure/repositories/filters_repository.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/filter_modal.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/loader_projects.dart';
import 'package:manager_projects_app/ui/utils/methods/functions_string.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';

class FilterPage extends StatefulWidget {
  final FilterData filterData;
  const FilterPage({super.key, required this.filterData});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage>
    with SingleTickerProviderStateMixin {
  bool isLoadApp = true;
  late TabController _tabController;
  List<Project> listProjects = [];
  List<Task> listTasks = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadDataInitial(widget.filterData);
  }

  loadDataInitial(FilterData filterData) async {
    try {
      setState(() {
        isLoadApp = true;
      });
      final dataResponse = await FiltersRepository.getFilter(filterData);
      if (dataResponse.success && dataResponse.data != null) {
        setState(() {
          listProjects = dataResponse.data?.listProject ?? [];
          listTasks = dataResponse.data?.listTask ?? [];
          isLoadApp = false;
        });
      }
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isLoadApp = false;
      });
    }
  }

  showDialogFilter() async {
    final filterData = await showDialog<FilterData?>(
      context: context,
      builder: (BuildContext context) {
        return const FilterModal();
      },
    );
    if (filterData != null) {
      log(filterData.name);
      if (filterData.name != "" || filterData.statusList.isNotEmpty) {
        loadDataInitial(FilterData(
            name: filterData.name, statusList: filterData.statusList));
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadApp) {
      return Scaffold(
          appBar: AppBar(
              iconTheme:
                  const IconThemeData(color: AppColors.contentColorWhite),
              backgroundColor: AppColors.secondary,
              title: Text("Filtrar",
                  style: TextStyle(color: AppColors.contentColorWhite))),
          body: const LoaderListProject());
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.contentColorWhite),
        backgroundColor: AppColors.secondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Filtrar",
              style: TextStyle(color: AppColors.contentColorWhite),
            ),
            CircleAvatar(
                child: IconButton(
                    onPressed: () async {
                      showDialogFilter();
                    },
                    icon: const Icon(Icons.search, size: 25)))
          ],
        ),
        bottom: TabBar(
          indicatorColor: AppColors.contentColorWhite,
          controller: _tabController,
          tabs: const [
            Tab(
                child: Text("Proyectos",
                    style: TextStyle(color: AppColors.contentColorWhite))),
            Tab(
              child: Text("Tareas",
                  style: TextStyle(color: AppColors.contentColorWhite)),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PageProjects(listProject: listProjects),
          PageTasks(listTask: listTasks),
        ],
      ),
    );
  }
}

class PageProjects extends StatelessWidget {
  final List<Project> listProject;
  const PageProjects({super.key, required this.listProject});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
            const SizedBox(height: 20),
          listProject.isEmpty ? const Text('No hay proyectos',style: TextStyle(fontSize: 17),) : Container(),
          ...listProject
              .map((e) => CardItemProject(
                    name: e.name,
                    description: e.description,
                  ))
              .toList()
        ],
      ),
    );
  }
}

class PageTasks extends StatelessWidget {
  final List<Task> listTask;
  const PageTasks({super.key, required this.listTask});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
            const SizedBox(height: 20),
          listTask.isEmpty ? const Text('No hay tareas',style: TextStyle(fontSize: 17),) : Container(),
          ...listTask.map((task) => CardItemTask(task: task))
        ],
      ),
    );
  }
}

class CardItemProject extends StatelessWidget {
  final String name;
  final String description;
  const CardItemProject(
      {super.key, required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(description)
            ],
          ),
        ),
      ),
    );
  }
}

class CardItemTask extends StatelessWidget {
  final Task task;
  const CardItemTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(task.description),
              Text(
                statusToString(task.status),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
