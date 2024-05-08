import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/enums/status.dart';
import 'package:manager_projects_app/infrastructure/domain/models/filter_data.dart';

/*
class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  String textValue = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Opciones de filtro:',style: TextStyle(fontWeight: FontWeight.bold)),
            CheckboxListTile(
              title:const Text('Por hacer'),
              value: isChecked1,
              onChanged: (value) {
                setState(() {
                  isChecked1 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('En progreso'),
              value: isChecked2,
              onChanged: (value) {
                setState(() {
                  isChecked2 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Completadas'),
              value: isChecked3,
              onChanged: (value) {
                setState(() {
                  isChecked3 = value!;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Filtro de texto:',style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              onChanged: (value) {
                setState(() {
                  textValue = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Ingrese el texto de filtro',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'isChecked1': isChecked1,
                      'isChecked2': isChecked2,
                      'isChecked3': isChecked3,
                      'textValue': textValue,
                    });
                  },
                  child: Text('Aplicar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

*/
class FilterModal extends StatefulWidget {
  const FilterModal({Key? key}) : super(key: key);

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final List<Map<Status, bool>> filterOptions = [
    {Status.todo: false},
    {Status.inProgress: false},
    {Status.completed: false},
  ];
  String textValue = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Opciones de filtro:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...filterOptions.map((option) {
                final status = option.keys.first;
                return CheckboxListTile(
                  title: Text(fromStatusText(status)),
                  value: option[status],
                  onChanged: (value) {
                    setState(() {
                      option[status] = value!;
                    });
                  },
                );
              }),
              const SizedBox(height: 20),
              const Text(
                'Filtro de texto:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    textValue = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Ingrese el texto de filtro',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final List<Status> statusList = [];
                      for (final option in filterOptions) {
                        final status = option.keys.first;
                        if (option[status]!) {
                          statusList.add(status);
                        }
                      }
                      FilterData filterData = FilterData(
                          name: textValue, statusList: statusList);
                      Navigator.pop(context, filterData);
                    },
                    child: const Text('Aplicar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
