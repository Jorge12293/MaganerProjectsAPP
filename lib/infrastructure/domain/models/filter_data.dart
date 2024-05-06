import 'package:manager_projects_app/infrastructure/domain/enums/status.dart';

class FilterData {
  String name;
  List<Status> statusList;
  FilterData({
    required this.name,
    required this.statusList,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "statusList": statusList.isEmpty ? [] : statusList.map((e) => e.value).toList(),
      };      
}

