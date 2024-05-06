import 'package:manager_projects_app/infrastructure/domain/enums/status.dart';

class TaskUpdateStatusDto {
  Status status;

  TaskUpdateStatusDto({
    required this.status,
  });
  Map<String, dynamic> toJson() => {
        "status": status.value,
      };
}
