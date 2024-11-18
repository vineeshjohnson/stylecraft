import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  const NormalButton(
      {super.key,
      required this.onTap,
      required this.buttonTxt,
      this.color,
      this.widgets});

  final VoidCallback onTap;
  final String buttonTxt;
  final Color? color;
  final Widget? widgets;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        backgroundColor: color ?? Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: widgets != null
            ? widgets
            : Text(
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
