import 'package:flutter/material.dart';
import 'package:manager_projects_app/helpers/data_app/list_home_menu_item.dart';
import 'package:manager_projects_app/infrastructure/repositories/auth_repository.dart';
import 'package:manager_projects_app/infrastructure/repositories_local/user_local_repository.dart';
import 'package:manager_projects_app/ui/routes/routes_name.dart';
import 'package:manager_projects_app/ui/utils/class/home_menu_item.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';
import 'package:manager_projects_app/ui/widgets/dialog_information_widget.dart';

class DrawerWidget extends StatefulWidget {
  final HomeMenuItem? selectHomeMenuItem;
  final Function(String) onChangeScreen;
  const DrawerWidget(
      {super.key, required this.onChangeScreen, this.selectHomeMenuItem});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  closeSession() async {
    final resp = await showDialogInformation(
        context: context,
        title: "Cerrar Sesión",
        description: "¿Seguro desea cerrar sesión?");
    if (resp != null && resp) {
      await AuthRepository.signOut();
      await UserLocalRepository.deleteUser();
      navigatePageAuth();
    }
  }

  navigatePageAuth() {
    Navigator.pushReplacementNamed(context, RoutesName.auth);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      width: 250,
      child: SizedBox(
        height: screenHeight,
        child: Column(
          children: <Widget>[
            const _DrawerHeader(title: 'Administrador'),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ...listHomeMenuItem
                      .map((item) => ListTile(
                            selected:
                                widget.selectHomeMenuItem?.tag == item.tag,
                            leading: Icon(item.icon),
                            title: Text(item.title),
                            onTap: () => widget.onChangeScreen(item.tag),
                          ))
                      .toList(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Salir'),
                onTap: () => closeSession(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatefulWidget {
  final String title;
  const _DrawerHeader({required this.title});

  @override
  State<_DrawerHeader> createState() => _DrawerHeaderState();
}

class _DrawerHeaderState extends State<_DrawerHeader> {
  String name="";
  String email="";
  @override
  void initState() {
    super.initState();
    loadData();
  }
  loadData() async{
      final user =  await UserLocalRepository.getUser();
      name = user?.username ??"";
      email = user?.email ??"";
      setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
      height: 190,
      width: 250,
      child:  DrawerHeader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const CircleAvatar(
              radius: 30,
              child: Icon(Icons.person,
                  color: AppColors.secondary, size: 50),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: Text(name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.contentColorWhite,
                fontSize: 24,
              ),
            )),
            const SizedBox(height: 10),
            Flexible(
              flex: 1,
              child: Text(
                email,
                textAlign: TextAlign.center,
                style:const  TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.contentColorWhite,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
