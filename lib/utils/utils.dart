import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/padding.dart';

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

void showSnackbar(BuildContext context, String message, {int? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration ?? 4),
    ),
  );
}

void showBottomModal({required BuildContext context, required Widget child}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Makes the modal full height
    backgroundColor: const Color.fromRGBO(255, 0, 0, 0),
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height *
          0.6, // Set the height to 60% of the screen's height
      child: Container(
        padding: KPadding.a24,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30), // Add rounded corners to the top
          ),
          color: Colors.white,
        ),
        child: child,
      ),
    ),
  );
}
