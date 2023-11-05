import 'package:flutter/material.dart';

void navigatorPush(BuildContext context, Widget screen) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  VoidCallback? onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (onConfirm != null) {
                onConfirm();
              }
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}
