import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.onTap,
    required this.buttonTxt,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final VoidCallback onTap;
  final String buttonTxt;

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
        backgroundColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Text(
          buttonTxt,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
