import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  // final String title;
  final String message;
  final Color textColor;

  const CustomDialog(
      {super.key, required this.message, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      content: DefaultTextStyle(
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontFamily: 'Recoleta',
          fontWeight: FontWeight.w500,
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
      actions: <Widget>[
        Center(
          child: TextButton(
            child: const Text(
              'Close',
              style: TextStyle(
                color: Color(0xFF6096B4),
                fontSize: 15,
                fontFamily: 'Recoleta',
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  static void show(BuildContext context, String message, Color textColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          message: message,
          textColor: textColor,
        );
      },
    );
  }
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('An Error Ocurred!'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}
