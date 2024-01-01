import 'package:flutter/material.dart';

class ModalDialog extends StatelessWidget {
  const ModalDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('No Data Found'),
      content:
          const Text('Please check your search criteria or try again later.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
