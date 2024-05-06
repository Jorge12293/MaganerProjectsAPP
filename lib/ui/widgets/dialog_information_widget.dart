import 'package:flutter/material.dart';
import 'package:manager_projects_app/ui/utils/theme/app_colors.dart';

Future<bool?> showDialogInformation(
    {required BuildContext context,
    required String title,
    required String description}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title.toUpperCase(), textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: AppColors.contentColorWhite),
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.contentColorWhite,
                foregroundColor: AppColors.contentColorBlack),
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
}

Future<bool?> showDialogError(
    {required BuildContext context,
    String title = "Error",
    String description = "Ocurrió un error intente más tarde"}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title.toUpperCase(), textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.contentColorRed,
                foregroundColor: AppColors.contentColorWhite),
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}

Dialog dialogLoading(String message) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );

Future<void> showLoadingDialog(String message, BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return dialogLoading(message);
    },
  );
}

Future<bool> dialogAccept( BuildContext context, String title, String description) async {
  final resp = await showDialogInformation(
      context: context, title: title, description: description);
  if (resp != null && resp) {
    return true;
  }
  return false;
}
