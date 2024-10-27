import 'package:flutter/material.dart';

class DontHaveAccountWidget extends StatelessWidget {
  const DontHaveAccountWidget({
    super.key,
    required this.voidCallback,
  });
  final VoidCallback voidCallback;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        TextButton(
          onPressed: voidCallback,
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
