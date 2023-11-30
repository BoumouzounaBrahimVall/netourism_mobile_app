import 'package:flutter/material.dart';

Future<void> showDialogWidget(
    BuildContext context, String title, String content) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        content: Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium!.merge(
              TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16)),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
