import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/models/project.dart';
import 'package:manager_projects_app/ui/routes/routes_name.dart';

class CardProject extends StatelessWidget {
  final Project project;
  const CardProject({super.key, required this.project});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
               Expanded(
                  child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    child: Text(project.name,style:const TextStyle(fontSize: 14), textAlign: TextAlign.center),
                  ),
                  ItemCard(
                      title: "Descripción",
                      value: project.description),
                ],
              )),
              CircleAvatar(
                child: IconButton(onPressed: () {
                  Navigator.pushNamed(context, RoutesName.formProject,arguments: project);
              }, icon:const Icon(Icons.arrow_forward_ios))
              )
              
            ],
          ),
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String title;
  final String value;
  const ItemCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
