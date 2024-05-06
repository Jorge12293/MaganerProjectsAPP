import 'package:flutter/material.dart';
import 'package:manager_projects_app/infrastructure/domain/enums/status.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';

class ContainerButtonStatus extends StatelessWidget {
  final Status? statusSelect;
  final Status status;
  final void Function()? onTap;
  const ContainerButtonStatus(
      {super.key,
      required this.statusSelect,
      required this.status,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Card(
            color: statusSelect == status ? AppColors.secondary : null,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(fromStatusText(status),
                    style: TextStyle(
                        color: statusSelect == status
                            ? AppColors.contentColorWhite
                            : null)))),
      ),
    );
  }
}
