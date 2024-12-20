import 'package:flutter/material.dart';

class Textformfields extends StatelessWidget {
  const Textformfields({
    super.key,
    this.controller,
    required this.icon,
    required this.labeltext,
    this.validator,
    this.readonly,
    this.obscureText = false, // Default value set to false
  });

  final TextEditingController? controller;
  final Icon icon;
  final String labeltext;
  final String? Function(String?)? validator;
  final bool? readonly;
  final bool obscureText; // New optional parameter for obscure text

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly == true ? readonly! : false,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureText, // Apply obscureText here
      decoration: InputDecoration(
        labelText: labeltext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: icon,
      ),
      validator: validator,
    );
  }
}
