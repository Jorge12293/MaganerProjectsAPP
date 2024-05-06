import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/models/task.dart';
import 'package:manager_projects_app/infrastructure/domain/models/user_app.dart';
import 'package:manager_projects_app/infrastructure/repositories/user_repository.dart';
import 'package:manager_projects_app/ui/provider/user_provider.dart';
import 'package:manager_projects_app/ui/widgets/snack_bart_custom.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  final Task task;
  const UserList({super.key, required this.task});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final searchController = TextEditingController();
  List<UserApp> listUsers = [];
  List<UserApp> listUsersData = [];
  bool isLoadApp = false;

  @override
  void initState() {
    super.initState();
    searchController.addListener(onChange);
    loadDataInitial();
  }

  loadDataInitial() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if(userProvider.listUserApp.isNotEmpty){
      listUsers = userProvider.listUserApp;
      listUsersData = userProvider.listUserApp;
      return;
    }

    try {
      setState(() {
        isLoadApp = true;
      });
      final dataListUsers = await UserRepository.listUsers();
      if (!dataListUsers.success) {
        showMessageErrorHandle(dataListUsers.message);
        return;
      }
      listUsers = [...dataListUsers.data];
      listUsersData = [...dataListUsers.data];
      userProvider.listUserApp =  [...dataListUsers.data];
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

  void onChange() {
    String textToSearch = searchController.text;
    List<UserApp> listAux = [];
    if (textToSearch == '') {
      listUsers = [...listUsersData];
    } else {
      for (UserApp user in listUsersData) {
        if (user.username
                .toString()
                .toUpperCase()
                .contains(textToSearch.toUpperCase()) ||
            user.email
                .toString()
                .toUpperCase()
                .contains(textToSearch.toUpperCase())) {
          listAux.add(user);
        }
      }
      listUsers = [...listAux];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double withScreen = MediaQuery.of(context).size.width;

    if (isLoadApp) {
      return const SizedBox(
        width: 100,
        height: 70,
        child: Column(
          children: [
            Text('Cargado Usuario..'),
            SizedBox(height: 10),
            CircularProgressIndicator()
          ],
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: !isLoadApp ? () => Navigator.of(context).pop() : null,
              child:const CircleAvatar(
                child:  Icon(
                  Icons.close_rounded,
                  size: 35,
                ),
              ),
            )
          ],
        ),
        Container(
            width: withScreen / 1.05,
            height: 50,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                labelText: 'Buscar',
                prefixIcon: const Icon(Icons.search),
              ),
            )),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                listUsers.isEmpty
                    ? const Text('No hay Usuarios')
                    : const SizedBox.shrink(),
                ...listUsers.map((user) =>
                    CardInformationUser(user: user, task: widget.task)),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CardInformationUser extends StatelessWidget {
  final UserApp user;
  final Task task;
  const CardInformationUser(
      {super.key, required this.user, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: task.userId == user.userId ? Colors.green.shade100 : null,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            children: [
              task.userId == user.userId
                  ? CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.person_pin, size: 25)))
                  : CircleAvatar(
                      child: IconButton(
                          onPressed: () => Navigator.of(context).pop(user),
                          icon: const Icon(Icons.person_add, size: 25))),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.username.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(user.email),
                ],
              ))
            ],
          ),
        ));
  }
}
