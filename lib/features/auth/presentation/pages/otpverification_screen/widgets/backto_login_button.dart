import 'package:flutter/material.dart';

class BackToLoginButton extends StatelessWidget {
  const BackToLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
      ),
      child: const Text(
        'Back to Login',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
