import 'package:manager_projects_app/infrastructure/domain/enums/status.dart';

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return (text.substring(0, 1).toUpperCase() + text.substring(1)).trim();
}

  String statusToString(Status status) {
    switch (status) {
      case Status.todo:
        return 'Por hacer';
      case Status.inProgress:
        return 'En progreso';
      case Status.completed:
        return 'Completada';
      default:
        return '';
    }
  }