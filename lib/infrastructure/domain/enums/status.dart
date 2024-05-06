enum Status {
  todo("TODO"),
  inProgress("IN_PROGRESS"),
  completed("COMPLETED");
  final String value;
  const Status(this.value);
}

Status fromStringStatus(String value) {
  switch (value) {
    case "TODO":
      return Status.todo;
    case "IN_PROGRESS":
      return Status.inProgress;
    case "COMPLETED":
      return Status.completed;
    default:
      throw ArgumentError("Invalid value: $value");
  }
}

String fromStatusText(Status status) {
  switch (status) {
    case Status.todo:
      return "Por hacer";
    case Status.inProgress:
      return "En progreso";
    case Status.completed:
      return "Completada";
    default:
      throw ArgumentError("Invalid value: $status");
  }
}
