import 'package:flutter/material.dart';

class SentenceWidget extends StatelessWidget {
  const SentenceWidget({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Text(
      "We have sent a reset link to $email. Please reset your password and log in.",
      style: const TextStyle(
        fontSize: 18.0,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}
