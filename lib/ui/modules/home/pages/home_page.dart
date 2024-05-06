import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:manager_projects_app/helpers/data_app/list_home_menu_item.dart';
import 'package:manager_projects_app/infrastructure/domain/models/filter_data.dart';
import 'package:manager_projects_app/ui/modules/home/pages/filter_page.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/drawer_widget.dart';
import 'package:manager_projects_app/ui/modules/home/widgets/filter_modal.dart';
import 'package:manager_projects_app/ui/utils/class/home_menu_item.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeMenuItem? selectHomeMenuItem;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    selectHomeMenuItem = listHomeMenuItem.first; // Select first menu default
  }

  onChangeScreen({required String tag}) {
    selectHomeMenuItem = listHomeMenuItem.firstWhere((item) => item.tag == tag);
    Navigator.pop(context);
    setState(() {});
  }

  showDialogFilter() async {
    final filterData = await showDialog<FilterData?>(
      context: context,
      builder: (BuildContext context) {
        return const FilterModal();
      },
    );
    if (filterData != null) {
      log(filterData.name );
      if(filterData.name != "" || filterData.statusList.isNotEmpty){

      navigatePageFilter(
          FilterData(name: filterData.name, statusList: filterData.statusList));
      }
      
    }
  }

  navigatePageFilter(FilterData filterData) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FilterPage(filterData: filterData)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.contentColorWhite),
          backgroundColor: AppColors.secondary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectHomeMenuItem?.title ?? 'App',
                style: const TextStyle(color: AppColors.contentColorWhite),
              ),
              CircleAvatar(
                  child: IconButton(
                      onPressed: () async {
                        showDialogFilter();
                      },
                      icon: const Icon(Icons.search, size: 25)))
            ],
          )),
      drawer: DrawerWidget(
          onChangeScreen: (tag) => onChangeScreen(tag: tag),
          selectHomeMenuItem: selectHomeMenuItem),
      body: selectHomeMenuItem?.item ?? Container(),
    );
  }
}
