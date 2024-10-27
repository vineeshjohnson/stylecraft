import 'package:flutter/material.dart';

class ElevatedButtonLogin extends StatelessWidget {
  const ElevatedButtonLogin({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.onTap,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          onTap();
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        backgroundColor: const Color.fromARGB(255, 19, 11, 138),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
