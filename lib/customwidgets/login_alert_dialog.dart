import 'package:flutter/material.dart';

showLoginAlertDialog({
  required BuildContext context,
  required String message,
  required VoidCallback callback,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Login Required'),
      content: Text(message),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
            callback();
          },
          child: const Text('Login'),
        ),
      ],
    ),
  );
}
