import 'package:flutter/material.dart';

import '../strings/strings.dart';

class GoogleElevatedButton extends StatelessWidget {
  const GoogleElevatedButton({
    super.key,
    required this.ontap,
  });
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: ontap,
      icon: Image.asset(
        googleimage,
        height: 30.0,
        width: 30.0,
      ),
      label: const Text(
        'Connect with Google',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Colors.black26),
        ),
      ),
    );
  }
}
