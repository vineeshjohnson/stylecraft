import 'package:flutter/material.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Welcome to StyleCraft",
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'NewAmsterdam',
      ),
      textAlign: TextAlign.center,
    );
  }
}
