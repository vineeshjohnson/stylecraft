import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final VoidCallback buttonAction;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.buttonText,
    required this.buttonAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: buttonAction,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          child: Text(buttonText),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
